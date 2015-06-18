# encoding: utf-8

require 'pp'
require 'date'
require 'strscan'  ## StringScanner lib
require 'erb'


class File
  def self.read_utf8( path )
    text = open( path, 'r:bom|utf-8' ) do |file|
      file.read
    end
    text
  end
end # class File


class EventReader

  Event = Struct.new( :title, :place, :date, :start_date)


  def initialize( path )
    @text = File.read_utf8( path )
  end


  MONTH_EN = 'Jan|'+
             'Feb|'+
             'March|Mar|'+
             'April|Apr|'+
             'May|'+
             'June|Jun|'+
             'July|Jul|'+
             'Aug|'+
             'Sept|Sep|'+
             'Oct|'+
             'Nov|'+
             'Dec'

  MONTH_EN_TO_MM = {
        'Jan' => '1',
        'Feb' => '2',
        'Mar' => '3', 'March' => '3',
        'Apr' => '4', 'April' => '4',
        'May' => '5',
        'Jun' => '6', 'June' => '6',
        'Jul' => '7', 'July' => '7',
        'Aug' => '8',
        'Sep' => '9', 'Sept' => '9',
        'Oct' => '10',
        'Nov' => '11',
        'Dec' => '12' }

## examples:
## - 2015 @ Salzburg, Austria; Oct/17+18
## - 2015 @ Brussels / Brussel / Bruxelles; Jan/31+Feb/1
## - 2014 @ Porto de Galinhas, Pernambuco; Apr/24-27 (formerly: Abril Pro Ruby)

  DATE_ENTRY_REGEX = /\s+
                      (?<year>201\d)   ## year
                      \s+
                       @            ## at location
                      \s+
                      [^;]+        ##  use ; as separator between place and date
                      ;
                      \s+
                      (?<month_en>#{MONTH_EN})
                      \/
                      (?<day>[0-9]{1,2})          ## start date
                      /x


## example:
## - [RubyWorld Conference - rubyworldconf](http://www.rubyworld-conf.org/en)

  LINK_ENTRY_REGEX = /\s+
                       \[
                         [^\]]+
                       \]
                       \(
                        [^\)]+
                       \)
                     /x


  def read

    events = []

    last_link_entry = nil

    @text.each_line do |line|

      puts "line: >#{line}<"
      line = line.rstrip  ## remove (possible) trailing newline

      break if line =~ /^## More/   #  stop when hitting >## More< section
      next  if line =~ /^\s*$/      #  skip blank lines

      m = nil
      if line =~ /^[ ]*-[ ]*/  ##  list item
        if( m=LINK_ENTRY_REGEX.match( line ) )
          puts " link entry: #{line}"

          s = StringScanner.new( line )
          s.skip( /[ ]*-[ ]*/ )  ## skip leading list
          last_link_entry = s.rest.rstrip  ## remove trailing spaces to
        elsif( m=DATE_ENTRY_REGEX.match( line ) )
          year     = m[:year]
          month_en = m[:month_en]
          month    = MONTH_EN_TO_MM[ month_en ]
          day      = m[:day]
          start_date = Date.new( year.to_i, month.to_i, day.to_i )
          pp start_date

          puts " date entry: #{line}"        
          puts "   start_date: #{start_date}, year: #{year}, month_en: #{month_en}, month: #{month} day: #{day} => #{last_link_entry}"

          s = StringScanner.new( line )
          s.skip( /[ ]*-[ ]*/ )  ## skip leading list
          s.skip_until( /@/ )

          place = s.scan( /[^;]+/ ) ## get place (everything until ; (separator))
          place = place.strip          
          puts "  place: #{place}, rest: >#{s.rest}<"

          s.skip( /;/ )
          s.skip( /[ ]*/ ) ## skip whitespaces
          date  = s.scan( /[^ ]+/ ) # e.g. everything untils first space (or end-of-line)

          title = last_link_entry

          event = Event.new( title, place, date, start_date )
          pp event
          events << event
        else
          puts "  *** skip list item line: #{line}"
        end
      else
        puts "  *** skip line: #{line}"
      end
    end
    
    events
  end

end # class EventReader


class EventCalendar

  attr_accessor :events

  def initialize( events )
    @events = events.sort { |l,r| r.start_date <=> l.start_date }   ## sort events by date (newest first)
    @tmpl = File.read_utf8('./CALENDAR.md.erb' )
  end

  def render
    ERB.new( @tmpl, nil, '<>' ).result( binding )   # <> omit newline for lines starting with <% and ending in %>
  end
  
  def save
    File.open( 'CALENDAR.md', 'w' ) do |f|
      f.write( render )
    end
  end
end # class EventCalendar



########################
# run (main code)

events = EventReader.new( './README.md' ).read
pp events

EventCalendar.new( events ).save

