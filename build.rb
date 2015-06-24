# encoding: utf-8


require 'eventdb'     ## note: install use:
                      ##  $ gem install eventdb   (see github.com/textkit/event.db)
                      ## note: make sure sqlite3 is instaled too
                      ##  $ gem install sqlite3


r = EventDb::EventReader.from_file( './README.md' )
events = r.read

db = EventDb::MemDatabase.new
db.add( events )

cal = EventDb::EventCalendar.new
buf = cal.render( template: "./templates/CALENDAR.md.erb" )
pp buf

File.open( './CALENDAR.md', 'w' ) do |f|
  f.write buf
end

puts 'Done.'
