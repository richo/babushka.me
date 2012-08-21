class RestrictSourceUriToGit < ActiveRecord::Migration
  def up
    Source.where("uri !~ '^git'").each(&:destroy)

    execute <<-SQL
      ALTER TABLE sources ADD CHECK (uri ~ '^git')
    SQL
  end
end
