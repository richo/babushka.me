require 'haml'
require 'kramdown'
require 'coderay'

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

module HamlHelpers
  module_function

  def markdown text
    Kramdown::Document.new(text.strip).to_html
  end

  def highlight text, lang
    "<pre><code class='#{lang}'>#{CodeRay.scan(text.strip, lang).span(:css => :class)}</code></pre>"
  end

  def strip_tag tag, text
    markdown(text).sub(%r{^<#{tag}>},  '').sub(%r{</#{tag}>$}, '')
  end

  def captioned text, lang
    figure(text) {|code,caption| [
      highlight(code, lang),
      strip_tag('p', markdown(caption))
    ] }
  end

  def pre_captioned text, lang
    figure(text, %w[precaption]) {|code,caption| [
      highlight(code, lang),
      "<pre><code>#{strip_tag('p', markdown(caption))}</code></pre>"
    ] }
  end

  def figure text, classes = []
    code, caption = yield(*text.split("\n\n", 2))

    %Q{
      <figure class="#{classes.push('code').join(' ')}">
        #{code}
        <figcaption>
          #{caption}
        </figcaption>
      </figure>
    }
  end
end

# This is required because kramdown isn't one of haml's default processors.
module Haml::Filters::Md
  include Haml::Filters::Base
  def render text
    HamlHelpers.markdown(text)
  end
end

module Haml::Filters::Preruby
  include Haml::Filters::Base
  def render text
    HamlHelpers.highlight(text, :ruby)
  end
end

module Haml::Filters::Presql
  include Haml::Filters::Base
  def render text
    HamlHelpers.highlight(text, :sql)
  end
end

module Haml::Filters::Prediff
  include Haml::Filters::Base
  def render text
    HamlHelpers.highlight(text, :diff)
  end
end

module Haml::Filters::Captionedruby
  include Haml::Filters::Base
  def render text
    HamlHelpers.captioned(text, :ruby)
  end
end

module Haml::Filters::Precaptionedruby
  include Haml::Filters::Base
  def render text
    HamlHelpers.pre_captioned(text, :ruby)
  end
end

project.helpers {
  def git_ref
    `git rev-parse --short HEAD`.strip
  end
}

project.assume_content_negotiation = true
project.assume_directory_index = true
