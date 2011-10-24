dep 'on deploy' do
  requires [
    'built',
    'db backed up',
    'db migrated'
  ]
end

dep 'built', template: 'benhoskings:task' do
  run {
    shell "bundle exec nanoc compile", log: true
  }
end

dep 'db backed up' do
  @backup_time = Time.now

  def backup_prefix; "~/sqldumps".p end
  def refspec; shell "git rev-parse --short HEAD" end
  def sqldump; backup_prefix / "babushka.me-#{@backup_time.strftime("%Y-%m-%d-%H:%M:%S")}-#{refspec}.psql" end
  def backup_path; "#{sqldump}.gz".p end

  met? { backup_path.exists? }
  before { backup_prefix.mkdir }
  meet { log_shell "Creating #{sqldump} from babushka.me", "pg_dump babushka.me > '#{sqldump}' && gzip -9 '#{sqldump}'" }
  after { log_shell "Removing old sqldumps", %Q{ls -t -1 #{backup_prefix} | tail -n+6 | while read f; do rm "#{backup_prefix}/$f"; done} }
end

dep 'db migrated' do
  requires_when_unmet 'benhoskings:maintenance page up'
  met? {
    if @run
      true # done
    else
      # If the branch was changed, git supplies 0000000 for var(:old_id), so
      # it looks the commit range is 'everything'.
      old_id = var(:old_id)[/^0+$/] ? '' : var(:old_id)
      pending = shell("git diff --numstat #{old_id}..#{var(:new_id)}").split("\n").grep(/^[\d\s]+db\/migrate\//)
      if pending.empty?
        log "No new migrations."
        true
      else
        log "#{pending.length} migration#{'s' unless pending.length == 1} to run:"
        pending.each {|p| log p }
        false
      end
    end
  }
  meet {
    shell 'bundle exec rake db:migrate --trace RAILS_ENV=production', log: true
    @run = true
  }
end
