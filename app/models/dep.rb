class Dep < ActiveRecord::Base

  belongs_to :source

  has_many :runs, :dependent => :destroy

  validates_presence_of :source, :name
  validates_uniqueness_of :name, :scope => :source_id

  def self.search term
    where "name ILIKE ?", "%#{term}%"
  end

  def runs_this_week
    runs.this_week.count
  end

  def total_success_rate
    1.0 * runs.where(result: 'ok').count / runs.count
  end

  def success_rate_this_week
    1.0 * runs.this_week.where(result: 'ok').count / runs.this_week.count
  end

  def info
    {
      name: name,
      source_uri: source.uri,
      total_runs: runs.count,
      runs_this_week: runs_this_week,
      total_success_rate: total_success_rate,
      success_rate_this_week: success_rate_this_week
    }
  end
end
