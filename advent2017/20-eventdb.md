
_Ruby Conferences from Around the World - Europe • North America • South America • Asia • Africa • Pacific / Oceania_

# eventdb library (and command line tools) - Build Your Own What's On / What's Up Event Calendar from READMEs in (Structured) Text

github: [textkit/event.db](https://github.com/textkit/event.db),
rubygems: [eventdb](https://rubygems.org/gems/eventdb),
rdoc: [eventdb](http://rubydoc.info/gems/eventdb) ++
more: [comments on reddit, please!](https://www.reddit.com/r/ruby/comments/7l43g2/day_20_ruby_advent_calendar_2017_build_your_own/)



## What's the eventdb library?

The eventdb library ships with an ready-to-use event.db SQL schema 
and ActiveRecord models and an READMEs (structured)-text-to-event reader (parser).

## Format

If you follow in your READMEs the (structured) rules when typing your events e.g.:

Option 1) Classic (Simple) Style

```
- [RubyKaigi](http://rubykaigi.org)
    - 2018 @ Sendai; May/31-June/2
```

Option 2) Modern (New) Style

```
- **RubyKaigi** (web: [rubykaigi.org](http://rubykaigi.org)))
    - 2018 @ Sendai; May/31-June/2
```

the reading results in:

```
#<EventDb::Model::Event:0xa286a54
  id:         1,
  title:      "RubyKaigi",
  link:       "http://rubykaigi.org",
  place:      "Sendai > Japan > Asia",
  start_date: Thu, 31 May 2018,
  end_date:   Sat, 2 Jun 2018,
  days:       3,
  created_at: 2017-12-20 08:51:52 UTC,
  updated_at: 2015-12-20 08:51:52 UTC>
```

Note: The headings hierarchy (starting w/ heading level 2) gets added to the place as a
geo tree. Example:

```
## Europe

### Central Europe

#### Germany

##### Bavaria

###### Upper Franconia
```

resulting in:

```
Upper Franconia › Bavaria › Germany › Central Europe › Europe
```



## Usage

In your scripts fetch the README pages and built an in-memory SQLite database on demand.
Example:

``` ruby
url = "https://github.com/planetruby/awesome-events/raw/master/README.md"

r = EventDb::EventReader.from_url( url )
events = r.read

db = EventDb::MemDatabase.new    # note: use in-memory SQLite database
db.add( events )


today = Date.today

puts 'Upcoming Ruby Conferences:'
puts ''

on = EventDb::Model::Event.live( today )
on.each do |e|
  current_day = today.mjd - e.start_date.mjd + 1   # calculate current event day (1,2,3,etc.) 
  puts "  NOW ON #{current_day}d    #{e.title} #{e.start_date.year}, #{e.date_str} (#{e.days}d) @ #{e.place}"
end

puts '' if on.any?

up = EventDb::Model::Event.limit( 17 ).upcoming( today )
up.each do |e|
  diff_days = e.start_date.mjd - today.mjd    # note: mjd == Modified Julian Day Number
  puts "  in #{diff_days}d  #{e.title}, #{e.date_str} (#{e.days}d) @ #{e.place}"
end
```

will print (†):

```
Upcoming Ruby Conferences:

  in 37d  Ruby on Ice Conference, Fri-Sun Jan/26-28 (3d) @ Tegernsee, Bavaria (near Munich / München) > Germany / Deutschland > Central Europe > Europe
  in 43d  RubyFuza, Thu-Sat Feb/1-3 (3d) @ Cape Town > South Africa > Africa
  in 51d  RubyConf India, Fri+Sat Feb/9+10 (2d) @ Bengaluru > India > Asia
  in 78d  RubyConf Australia, Thu+Fri Mar/8+9 (2d) @ Sydney > Australia > Pacific / Oceania
  in 85d  RubyConf Philippines, Thu-Sat Mar/15-17 (3d) @ Manila > Philippines / Pilipinas > Asia
  in 86d  wroc_love.rb, Fri-Sun Mar/16-18 (3d) @ Wroclaw > Poland > Central Europe > Europe
  in 92d  Bath Ruby Conference, Thu+Fri Mar/22+23 (2d) @ Bath, Somerset > England > Western Europe > Europe
  in 118d  RailsConf, Tue-Thu Apr/17-19 (3d) @ Pittsburgh, Pennsylvania > United States > North America > America
  in 128d  RubyConf Taiwan, Fri+Sat Apr/27+28 (2d) @ Taipei > Taiwan > Asia
  in 134d  Rubyhack: High Altitude Coding Konference, Thu+Fri May/3+4 (2d) @ Salt Lake City, Utah > Southwest > United
tates > North America > America
  in 156d  Balkan Ruby Conference, Fri+Sat May/25+26 (2d) @ Sofia > Bulgaria > Eastern Europe > Europe
  in 162d  RubyKaigi, Thu-Sat May/31-Jun/2 (3d) @ Sendai > Japan > Asia
  in 184d  RubyConf Kenya, Fri Jun/22 (1d) @ Nairobi > Kenya > Africa
  in 190d  Paris.rb XXL Conf, Thu+Fri Jun/28+29 (2d) @ Paris > France > Western Europe > Europe
  ...
```

(†): on December, 20th in 2017 :-).

Note: A ready-to-use command-line tool e.g. rubyconf 
for listing upcoming ruby conferences & camps
is bundled up in the [whatson library & command line tool suite](https://github.com/textkit/whatson)
e.g. try:

```
$ rubyconf
```

resulting (again) in (†):

```
Upcoming Ruby Conferences:

  in 37d  Ruby on Ice Conference, Fri-Sun Jan/26-28 (3d) @ Tegernsee, Bavaria (near Munich / München) > Germany / Deutschland > Central Europe > Europe
  in 43d  RubyFuza, Thu-Sat Feb/1-3 (3d) @ Cape Town > South Africa > Africa
  in 51d  RubyConf India, Fri+Sat Feb/9+10 (2d) @ Bengaluru > India > Asia
  in 78d  RubyConf Australia, Thu+Fri Mar/8+9 (2d) @ Sydney > Australia > Pacific / Oceania
  in 85d  RubyConf Philippines, Thu-Sat Mar/15-17 (3d) @ Manila > Philippines / Pilipinas > Asia
  in 86d  wroc_love.rb, Fri-Sun Mar/16-18 (3d) @ Wroclaw > Poland > Central Europe > Europe
  in 92d  Bath Ruby Conference, Thu+Fri Mar/22+23 (2d) @ Bath, Somerset > England > Western Europe > Europe
  in 118d  RailsConf, Tue-Thu Apr/17-19 (3d) @ Pittsburgh, Pennsylvania > United States > North America > America
  in 128d  RubyConf Taiwan, Fri+Sat Apr/27+28 (2d) @ Taipei > Taiwan > Asia
  in 134d  Rubyhack: High Altitude Coding Konference, Thu+Fri May/3+4 (2d) @ Salt Lake City, Utah > Southwest > United
tates > North America > America
  in 156d  Balkan Ruby Conference, Fri+Sat May/25+26 (2d) @ Sofia > Bulgaria > Eastern Europe > Europe
  in 162d  RubyKaigi, Thu-Sat May/31-Jun/2 (3d) @ Sendai > Japan > Asia
  in 184d  RubyConf Kenya, Fri Jun/22 (1d) @ Nairobi > Kenya > Africa
  in 190d  Paris.rb XXL Conf, Thu+Fri Jun/28+29 (2d) @ Paris > France > Western Europe > Europe
  ...
```

(†): on December, 20th in 2017 :-).



## Bonus: Public (Awesome) Event Datasets

- [Awesome Events @ Planet Ruby](https://github.com/planetruby/awesome-events) - a collection of awesome ruby events (meetups, conferences, camps, etc.) from around the world
- [Calendar @ football.db](https://github.com/openfootball/calendar) - a collection of awesome football tournaments, cups, etc. from around the world
- [Calendar @ beer.db](https://github.com/openbeer/calendar) - a collection of awesome beer events (oktoberfest, starkbierfest, etc.) from around the world

