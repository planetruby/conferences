# encoding: utf-8


###
#  note:
#    use   ruby ./build.rb    to run, that is, (re)-generate the CALENDAR.md page reading in the README.md

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

  MONTH_EN = MONTH_EN_TO_MM.keys.join('|')  # e.g. 'Jan|Feb|March|Mar|...'

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
    stack  = []   ## header/heading stack;  note: last_stack is stack.size; starts w/ 0

    last_link_entry = nil

    @text.each_line do |line|

      puts "line: >#{line}<"
      line = line.rstrip  ## remove (possible) trailing newline

      break if line =~ /^## More/   #  stop when hitting >## More< section
      next  if line =~ /^\s*$/      #  skip blank lines

      m = nil
      if line =~ /^[ ]*(#+)[ ]+/    ## heading/headers - note: must escpape #
          s = StringScanner.new( line )
          s.skip( /[ ]*/ )  ## skip whitespaces
          markers = s.scan( /#+/)
          level   = markers.size
          s.skip( /[ ]*/ )  ## skip whitespaces
          title   = s.rest.rstrip
          
          puts " heading level: #{level}, title: >#{title}<"

          level_diff = level - stack.size

          if level_diff > 0
            puts "[EventReader]    up  +#{level_diff}"
            ## FIX!!! todo/check/verify/assert: always must be +1
            if level_diff > 1
              puts "fatal: level step must be one (+1)"; exit 1
            end
          elsif level_diff < 0
            puts "[EventReader]    down #{level_diff}"
            level_diff.abs.times { stack.pop }
            stack.pop
          else
            ## same level
            stack.pop
          end
          stack.push( [level,title] )
          puts "  stack: #{stack.inspect}"
          
      elsif line =~ /^[ ]*-[ ]+/     ## list item
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

          ## note: cut of heading 1 (e.g. awesome-events title)
          more_places = stack[1..-1].reverse.map {|it| it[1] }.join(' › ')
          place = "#{place} › #{more_places}"
          puts "  place: #{place}"

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


class EventCursor
  def initialize( events )
    @events = events
  end

  def each
    state = State.new
    @events.each do |event|
       state.next( event )
       yield( event, state )
    end
  end

  class State
    def initialize
      @last_date  = Date.new( 1971, 1, 1 )
      @new_date   = true
      @new_year   = true
      @new_month  = true
    end
    def new_date?()  @new_date; end
    def new_year?()  @new_year; end
    def new_month?() @new_month; end

    def next( event )
      if @last_date.year  == event.start_date.year &&
         @last_date.month == event.start_date.month
           @new_date  = false
           @new_year  = false
           @new_month = false
      else
        @new_date = true
        ## new year?
        @new_year  = @last_date.year != event.start_date.year ? true : false
        ## new_month ?
        @new_month = (@new_year == true || @last_date.month != event.start_date.month) ? true : false
      end
      @last_date = event.start_date
    end

  end # class State

end # class EventCursor


class EventCalendar

  def initialize( events )
    @events = events.sort { |l,r| r.start_date <=> l.start_date }   ## sort events by date (newest first)
    @tmpl = File.read_utf8('./CALENDAR.md.erb' )
  end

  def events
    ## note: return new cursor  -- use decorator (instead of extra loop arg, why? why not?
    EventCursor.new( @events )
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
## pp events

EventCalendar.new( events ).save
