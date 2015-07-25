# Lamppost

[![Gem Version](http://img.shields.io/gem/v/lamppost.svg)](https://rubygems.org/gems/lamppost)
[![Dependency Status](https://gemnasium.com/scour/lamppost.svg)](https://gemnasium.com/scour/lamppost)
[![Build Status](https://travis-ci.org/scour/lamppost.svg)](https://travis-ci.org/scour/lamppost)
[![Code Climate](https://codeclimate.com/github/scour/lamppost/badges/gpa.svg)](https://codeclimate.com/github/scour/lamppost)
[![Coverage Status](https://coveralls.io/repos/scour/lamppost/badge.svg)](https://coveralls.io/r/scour/lamppost)

Lamppost provides basic OPML parsing. It provides a convenience class for straightforward parsing of XML and files, but because it causes a parser class to get registered with Feedjira, it also allows you to take fetch and parse files with Feedjira itself.

### Basic Usage

Pass in either a `File` or a `String`

```ruby
opml = Lamppost::OPML.new(response.body)
```
You have access to any elements from the OPML's `<head>`.

```ruby
title = opml.head.title
name = opml.head.owner_name
```

And the outlines from the `<body>`

```ruby
opml.outlines.each do |outline|
    text = outline.text
    url = outline.xml_url
end
```

### Feedjira

Behind the scenes Lampost uses Feedjira parser classes provided by the [feedjira-opml](https://www.github.com/farski/feedjira-opml) gem. That gem registers the OPML parser with Feedjira, so it is available any time Feedjira is used to parse a document.

```ruby
# Parse against OPML explicitly
Feedjira::Feed.parse_with(Feedjira::Parser::OPML, response.body)
```

```ruby
# Feedjira will implicitly match the OPML parser when
# it finds an <opml> tag
Feedjira::Feed.parse(response.body)
```

You could also use Feedjira's `fetch_and_parse` method if you'd like.
