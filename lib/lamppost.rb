require 'lamppost/version'
require 'nokogiri'

module Lamppost
  class OPML
    def initialize(file_or_xml)
      @xml = file_or_xml.is_a?(File) ? file_or_xml.read : file_or_xml
    end

    def title
      head[:title] if !head[:title].empty?
    end

    def date_created
      head[:dateCreated] if !head[:dateCreated].empty?
    end

    def date_modified
      head[:dateModified] if !head[:dateModified].empty?
    end

    def owner_name
      head[:ownerName] if !head[:ownerName].empty?
    end

    def owner_email
      head[:ownerEmail] if !head[:ownerEmail].empty?
    end

    def owner_id
      head[:ownerId] if !head[:ownerId].empty?
    end

    def docs
      head[:docs] if !head[:docs].empty?
    end

    def outlines
      document.css('opml > body > outline').inject([]) do |memo, node|
        type = node['type']
        text = node['text']
        xml_url = node['xmlUrl']
        memo << Struct.new(:type, :text, :xml_url).new(type, text, xml_url)
        memo
      end
    end

    private

    def document
      @document ||= Nokogiri::XML.parse(@xml)
    end

    def head
      @head ||= {
        title: document.css('opml > head > title').text,
        dateCreated: document.css('opml > head > dateCreated').text,
        dateModified: document.css('opml > head > dateModified').text,
        ownerName: document.css('opml > head > ownerName').text,
        ownerEmail: document.css('opml > head > ownerEmail').text,
        ownerId: document.css('opml > head > ownerId').text,
        docs: document.css('opml > head > docs').text,
      }
    end
  end
end
