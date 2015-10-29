require "lamppost/version"
require "feedjira/opml"

module Lamppost
  class OPML
    def initialize(file_or_xml)
      @xml = file_or_xml.is_a?(File) ? file_or_xml.read : file_or_xml
    end

    def head
      @head ||= document.head
    end

    def outlines
      @outlines ||= document.body.outlines
    end

    private

    def document
      @document ||= Feedjira::Feed.parse_with(Feedjira::Parser::OPML, @xml)
    end
  end
end
