$:.unshift File.join(File.dirname(__FILE__), "jekyll-scholar")

require 'jekyll/scholar'
require 'uri'

# https://github.com/inukshuk/jekyll-scholar/issues/30
# adapted for personal use: write html instead of markdown
module HtmlFilter
  class Htmllink < BibTeX::Filter
    def apply(value)
      value.to_s.gsub(URI.regexp(['http','https','ftp'])) { |c| $& }
    end
  end
end

# https://github.com/inukshuk/bibtex-ruby/issues/105
module BibTeX
    module Filters
        class LaTeX < Filter
            def apply(value)
                if %r{https?|ftps?}.match(value)
                    value.to_s.gsub! '\_','_'
                    return value
                else
                    ::LaTeX.decode(value)
                end
            end
        end
    end
end

# cf. https://github.com/inukshuk/jekyll-scholar/issues/70
# here used to be https://gist.github.com/iiegn/9784826af4b44bba93d1
# now, moved to https://github.com/iiegn/jekyll-scholar/tree/iiegn/master
