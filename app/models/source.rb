class Source < ActiveRecord::Base

  has_many :deps, :dependent => :destroy

  validates_presence_of :uri
  validates_uniqueness_of :uri
  validates_format_of :uri, with: %r{^git://}

end
