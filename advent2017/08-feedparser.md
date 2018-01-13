_The Future of Online News - The Future of Facebook & Co - Web Feeds, Web Feeds, Web Feeds_


# feedparser library - Read Web Feeds in XML, HTML, JSON, TXT and More; Build Your Own News Reader from Scratch in Twenty Lines

github: [feedparser/feedparser](https://github.com/feedparser/feedparser),
rubygems: [feedparser](https://rubygems.org/gems/feedparser),
rdoc: [feedparser](http://rubydoc.info/gems/feedparser) ++
more: [comments on reddit, please!](https://www.reddit.com/r/ruby/comments/7ih89q/day_8_ruby_advent_calendar_2017_feedparser_read/)



## What's a web feed?

A web feed (or news feed) is a (simple) document/text format
that:

(1) lets you publish a list of:

- status updates, blog postings, articles, pictures, cartoons, recordings, etc.

and that

(2) lets others subscribe to your updates.


Example:

``` json
{
    "version": "https://jsonfeed.org/version/1",
    "title": "Jason Fried's Microblog",
    "home_page_url": "https://micro.blog/jasonfried/",
    "feed_url": "https://micro.blog/jasonfried/feed.json",
    "author": {
        "name": "Jason Fried",
        "url": "https://micro.blog/jasonfried/",
        "avatar": "https://micro.blog/jasonfried/avatar.png"
    },
    "items": [
        {
            "id": "865767227416612864",
            "url": "https://micro.blog/jasonfried/status/865767227416612864",
            "content_text": "JSON Feed? I know that guy.",
            "date_published": "2017-05-19T20:12:00-00:00"
        }
    ]
}
```


## Aside: The Wonders of RSS - What's RSS!?

**Triva Quiz - Q: What's RSS?**

- [A] RDF Site Summary
- [B] Rich Site Summary
- [C] Really Simple Syndication
- [D] Really Simple, Stupid
- [E] Rapid Syndicaton Solution

RDF = Resource Description Framework


**Trivia Quiz - Find the Content - Q: What's your favorite way to add content in hypertext to RSS 2.0?**

- [A] `<description>`
- [B] `<content:encoded>`  from RDF/RSS 1.0 content module extension
- [C] `<media:content>`  from Yahoo! search extension
- [D] Other?  Please, tell!

Bonus: Is your content in plain text, in html, in xhtml, in html escaped?
Is your content a summary? or full text?



## The State of Web Feed Formats in 2017 - XML, JSON, YAML, HTML, TXT

Let's celebrate diversity! Live and let live!
Web feed formats today in 2017 include:

- RSS 2.0 (0.91, 0.92) a.k.a. Really Simple Syndication - in XML
- RSS 1.0 a.k.a. RDF Site Summary - in RDF/XML
- Atom - in XML
- JSON Feed - in - surprise, surprise - JSON
- Microformats (h-feed/h-entry) - in HTML
- Feed.TXT - in plain text; metadata in (simplified) YAML or JSON; Markdown

And some more.



## What's the feedparser library?

One library to rule them all! All your base are blong to feedparser.

In the end all formats are just 0 and 1s or:

- `feed.title`
- `feed.url`
- `feed.items[0].title`
- `feed.items[0].url`
- `feed.items[0].published`
- `feed.items[0].content_html` or `feed.items[0].content`
- `feed.items[0].content_text`
- `feed.items[0].summary`
- etc.

=> Let your computer handle the reading of web feeds ;-).


### Read Feed Example

``` ruby
require 'open-uri'
require 'feedparser'

txt = open( 'http://openfootball.github.io/feed.xml' ).read

feed = FeedParser::Parser.parse( txt )

puts feed.title
# => "football.db - Open Football Data"

puts feed.url
# => "http://openfootball.github.io/"

puts feed.items[0].title
# => "football.db - League Quick Starter Sample - Mauritius Premier League - Create Your Own Repo/League(s) from Scratch"

puts feed.items[0].url
# => "http://openfootball.github.io/2015/08/30/league-quick-starter.html"

puts feed.items[0].updated
# => Sun, 30 Aug 2015 00:00:00 +0000

puts feed.items[0].content
# => "Added a new quick starter sample using the Mauritius Premier League to get you started..."

...
```

or reading a feed in the new [JSON Feed](https://jsonfeed.org) format in - surprise, surprise - JSON;
note: nothing changes :-)

``` ruby
txt = open( 'http://openfootball.github.io/feed.json' ).read

feed = FeedParser::Parser.parse( txt )

puts feed.title
# => "football.db - Open Football Data"

puts feed.url
# => "http://openfootball.github.io/"

puts feed.items[0].title
# => "football.db - League Quick Starter Sample - Mauritius Premier League - Create Your Own Repo/League(s) from Scratch"

puts feed.items[0].url
# => "http://openfootball.github.io/2015/08/30/league-quick-starter.html"

puts feed.items[0].updated
# => Sun, 30 Aug 2015 00:00:00 +0000

puts feed.items[0].content_text
# => "Added a new quick starter sample using the Mauritius Premier League to get you started..."

...
```

### Microformats

Microformats let you mark up feeds and posts in HTML with
[`h-entry`](http://microformats.org/wiki/h-entry),
[`h-feed`](http://microformats.org/wiki/h-feed),
and friends.

Note: Microformats support in feedparser is optional.
Install and require the the [microformats library](https://github.com/indieweb/microformats-ruby) to read
feeds in HTML with Microformats.


``` ruby

require 'microformats'

text =<<HTML
<article class="h-entry">
  <h1 class="p-name">Microformats are amazing</h1>
  <p>Published by
    <a class="p-author h-card" href="http://example.com">W. Developer</a>
     on <time class="dt-published" datetime="2013-06-13 12:00:00">13<sup>th</sup> June 2013</time>

  <p class="p-summary">In which I extoll the virtues of using microformats.</p>

  <div class="e-content">
    <p>Blah blah blah</p>
  </div>
</article>
HTML

feed = FeedParser::Parser.parse( text )

puts feed.format
# => "html"
puts feed.items.size
# =>  1
puts feed.items[0].authors.size
# => 1
puts feed.items[0].content_html  
# => "<p>Blah blah blah</p>"
puts feed.items[0].content_text  
# => "Blah blah blah"
puts feed.items[0].title
# => "Microformats are amazing"
puts feed.items[0].summary
# => "In which I extoll the virtues of using microformats."
puts feed.items[0].published
# => 2013-06-13 12:00:00
puts feed.items[0].authors[0].name
# => "W. Developer"
...
```

## Samples

### Feed Reader

_Planet Feed Reader in 20 Lines of Ruby_

`planet.rb`:

``` ruby
require 'open-uri'
require 'feedparser'
require 'erb'

# step 1) read a list of web feeds

FEED_URLS = [
  'http://vienna-rb.at/atom.xml',
  'http://weblog.rubyonrails.org/feed/atom.xml',
  'http://www.ruby-lang.org/en/feeds/news.rss',
  'http://openfootball.github.io/feed.json',
]

items = []

FEED_URLS.each do |url|
  feed = FeedParser::Parser.parse( open( url ).read )
  items += feed.items
end

# step 2) mix up all postings in a new page

FEED_ITEM_TEMPLATE = <<EOS
<% items.each do |item| %>
  <div class="item">
    <h2><a href="<%= item.url %>"><%= item.title %></a></h2>
    <div><%= item.content %></div>
  </div>
<% end %>
EOS

puts ERB.new( FEED_ITEM_TEMPLATE ).result
```

Run the script:

```
$ ruby ./planet.rb      
```

Prints:

```
<div class="item">
  <h2><a href="http://vienna-rb.at/blog/2017/11/06/picks/">Picks / what the vienna.rb team thinks is worth sharing this week</a></h2>
  <div>
   <h3>6/11 Picks!!</h3>
   <p>In a series on this website we'll entertain YOU with our picks...
 ...
```

## Real World Usage

See the Planet Pluto feed reader family:

- [Planet Pluto](https://github.com/feedreader)  - static planet website generator
- [Planet Pluto Live](https://github.com/plutolive) - dynamic (live) planet web apps (using Sinatra, Rails, etc.)
