require 'org-ruby'

module Jekyll
  class OrgConverter < Converter
    safe false # might be safe, but as I'm unsure better to make no promises
    priority :low

    def matches(ext)
      ext == ".org"
    end

    def output_ext(ext)
      ".html"
    end

    def convert(content)
      Orgmode::Parser.new(content).to_html
    end
  end
end
