require_relative 'minitest_helper'

class TestLamppost < Minitest::Test
  describe 'Parser' do
    describe 'for basic OPML' do
      before do
        file = File.open(File.expand_path('../fixtures/basic.opml', __FILE__), 'r')
        @file_output = Lamppost::OPML.new(file)

        file2 = File.open(File.expand_path('../fixtures/basic.opml', __FILE__), 'r')
        @string_output = Lamppost::OPML.new(file2.read)
      end

      it 'gets the same title for strings and files' do
        assert_equal @string_output.head.title, @file_output.head.title
      end

      it 'gets the title' do
        title = 'Head Title'

        assert_equal title, @file_output.head.title
        assert_equal title, @string_output.head.title
      end

      it 'has no date_created' do
        assert_equal nil, @file_output.head.date_created
      end

      it 'has no date_modified' do
        assert_equal nil, @file_output.head.date_modified
      end

      it 'has no owner_name' do
        assert_equal nil, @file_output.head.owner_name
      end

      it 'has no owner_email' do
        assert_equal nil, @file_output.head.owner_name
      end

      it 'has no owner_id' do
        assert_equal nil, @file_output.head.owner_id
      end

      it 'gets the docs' do
        docs = 'http://dev.opml.org/spec2.html'

        assert_equal URI(docs), @file_output.head.docs
      end

      it 'has 3 outlines' do
        assert_equal 3, @file_output.outlines.count
      end

      it 'gets the first outline text' do
        text = 'Outline 1 text'

        assert_equal text, @file_output.outlines.first.text
      end
    end

    describe 'for subscription lists' do
      before do
        file = File.open(File.expand_path('../fixtures/subscription-list.opml', __FILE__), 'r')
        @output = Lamppost::OPML.new(file)
      end

      it 'gets required attributes for outlines' do
        text = 'Outline 1 text'
        xmlUrl = 'http://www.example.com/outline/1.rss'

        assert_equal 'rss', @output.outlines.first.type
        assert_equal text, @output.outlines.first.text
        assert_equal URI(xmlUrl), @output.outlines.first.xml_url
      end
    end
  end
end
