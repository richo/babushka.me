require 'haml'
require 'kramdown'

project.assume_content_negotiation = true
project.assume_directory_index = true

class Tilt::CustomKramdownTemplate < Tilt::Template
  def prepare
    @engine = Kramdown::Document.new(data, options)
    @output = nil
  end

  def evaluate(scope, locals, &block)
    @output ||= @engine.to_html
  end
end

Tilt.register Tilt::CustomKramdownTemplate, 'markdown', 'mkd', 'md'
Tilt.prefer Tilt::CustomKramdownTemplate

project.helpers {
  def git_ref
    `git rev-parse --short HEAD`.strip
  end
}