
_Six lines of almost sinatra "unobfuscated" and bundled up for easy (re)use_

# almost-sinatra library - Build Your Own Webframework From Scratch with Rack and Tilt in Less Than Ten Lines

github: [rubylibs/almost-sinatra](https://github.com/rubylibs/almost-sinatra),
rubygems: [almost-sinatra](https://rubygems.org/gems/almost-sinatra),
rdoc: [almost-sinatra](http://rubydoc.info/gems/almost-sinatra) ++
more: [comments on reddit, please!](https://www.reddit.com/r/ruby/comments/7hwxtf/day_6_ruby_advent_calendar_2017_almostsinatra/)


## What's Sinatra?

Simple (yet powerful and flexible) micro webframework.

``` ruby
require 'sinatra'

get '/' do
  'Hallo Vienna! Servus Wien!'
end
```

Trivia Quiz - Q: How Many Lines of Ruby Code?

- [A] 20 Lines
- [B] 200 Lines
- [C] 2 000 Lines
- [D] 20 000 Lines



## What's Almost Sinatra?

Sinatra refactored, only six lines now.
Library dependencies: Tilt and Rack (like Sinatra).  
A hack by [Konstantin Haase](https://github.com/rkh).


``` ruby
%w.rack tilt backports date INT TERM..map{|l|trap(l){$r.stop}rescue require l};$u=Date;$z=($u.new.year + 145).abs;puts "== Almost Sinatra/No Version has taken the stage on #$z for development with backup from Webrick"
$n=Sinatra=Module.new{a,D,S,q=Rack::Builder.new,Object.method(:define_method),/@@ *([^\n]+)\n(((?!@@)[^\n]*\n)*)/m
%w[get post put delete].map{|m|D.(m){|u,&b|a.map(u){run->(e){[200,{"Content-Type"=>"text/html"},[a.instance_eval(&b)]]}}}}
Tilt.default_mapping.lazy_map.map{|k,v|D.(k){|n,*o|$t||=(h=$u._jisx0301("hash, please");File.read(caller[0][/^[^:]+/]).scan(S){|a,b|h[a]=b};h);Kernel.const_get(v[0][0]).new(*o){n=="#{n}"?n:$t[n.to_s]}.render(a,o[0].try(:[],:locals)||{})}}
%w[set enable disable configure helpers use register].map{|m|D.(m){|*_,&b|b.try :[]}};END{Rack::Handler.get("webrick").run(a,Port:$z){|s|$r=s}}
%w[params session].map{|m|D.(m){q.send m}};a.use Rack::Session::Cookie;a.use Rack::Lock;D.(:before){|&b|a.use Rack::Config,&b};before{|e|q=Rack::Request.new e;q.params.dup.map{|k,v|params[k.to_sym]=v}}}
```

(Source: [almost_sinatra.rb](https://github.com/rkh/almost-sinatra/blob/master/almost_sinatra.rb))




## Almost Sinatra - A Breakdown Line by Line

### Line 1

``` ruby
%w.rack tilt date INT TERM..map{|l|trap(l){$r.stop}rescue require l};$u=Date;$z=($u.new.year + 145).abs;puts "== Almost Sinatra/No Version has taken the stage on #$z for development with backup from Webrick"
```

Breakdown:

``` ruby
require 'rack'
require 'tilt'

trap( 'INT' )  { $server.stop }  # rename $r to $server
trap( 'TERM' ) { $server.stop }

$port = 4567              # rename $z to $port

puts "== Almost Sinatra has taken the stage on #{$port} for development with backup from Webrick"
```


**Aside - What's rack?**

Lets you mix 'n' match servers and apps.

Lets you stack apps inside apps inside apps inside apps inside apps.

Good News: A Sinatra app is a Rack app.

Learn more about Rack @ [`rack.github.io`](http://rack.github.io).



**Aside - What's tilt?**


Tilt offers a standard "generic" interface for template engines.

Let's check-up what formats and template engines tilt includes out-of-the-box:

``` ruby
require 'tilt'

Tilt.mappings.each do |ext, engines|
  puts "#{ext.ljust(12)} : #{engines.inspect}"
end
```

Will result in:

``` ruby
str          : [Tilt::StringTemplate]
erb          : [Tilt::ErubisTemplate, Tilt::ERBTemplate]
rhtml        : [Tilt::ErubisTemplate, Tilt::ERBTemplate]
erubis       : [Tilt::ErubisTemplate]
etn          : [Tilt::EtanniTemplate]
etanni       : [Tilt::EtanniTemplate]
haml         : [Tilt::HamlTemplate]
sass         : [Tilt::SassTemplate]
scss         : [Tilt::ScssTemplate]
less         : [Tilt::LessTemplate]
rcsv         : [Tilt::CSVTemplate]
coffee       : [Tilt::CoffeeScriptTemplate]
nokogiri     : [Tilt::NokogiriTemplate]
builder      : [Tilt::BuilderTemplate]
mab          : [Tilt::MarkabyTemplate]
liquid       : [Tilt::LiquidTemplate]
radius       : [Tilt::RadiusTemplate]
markdown     : [Tilt::RedcarpetTemplate, Tilt::RedcarpetTemplate::Redcarpet2, Tilt::RedcarpetTemplate::Redcarpet1, Tilt::RDiscountTemplate, Tilt::BlueClothTemplate, Tilt::KramdownTemplate, Tilt::MarukuTemplate]
mkd          : [Tilt::RedcarpetTemplate, Tilt::RedcarpetTemplate::Redcarpet2, Tilt::RedcarpetTemplate::Redcarpet1, Tilt::RDiscountTemplate, Tilt::BlueClothTemplate, Tilt::KramdownTemplate, Tilt::MarukuTemplate]
md           : [Tilt::RedcarpetTemplate, Tilt::RedcarpetTemplate::Redcarpet2, Tilt::RedcarpetTemplate::Redcarpet1, Tilt::RDiscountTemplate, Tilt::BlueClothTemplate, Tilt::KramdownTemplate, Tilt::MarukuTemplate]
textile      : [Tilt::RedClothTemplate]
rdoc         : [Tilt::RDocTemplate]
wiki         : [Tilt::WikiClothTemplate, Tilt::CreoleTemplate]
creole       : [Tilt::CreoleTemplate]
mediawiki    : [Tilt::WikiClothTemplate]
mw           : [Tilt::WikiClothTemplate]
yajl         : [Tilt::YajlTemplate]
ad           : [Tilt::AsciidoctorTemplate]
adoc         : [Tilt::AsciidoctorTemplate]
asciidoc     : [Tilt::AsciidoctorTemplate]
html         : [Tilt::PlainTemplate]
```


### Line 2

``` ruby
$n=Module.new{extend Rack;a,D,S,q=Rack::Builder.new,Object.method(:define_method),/@@ *([^\n]+)\n(((?!@@)[^\n]*\n)*)/m
```

Breakdown:

``` ruby
$n = Module.new do
  app = Rack::Builder.new      # rename a to app
  req = nil                    # rename q to req
```


### Line 3

``` ruby
%w[get post put delete].map{|m|D.(m){|u,&b|a.map(u){run->(e){[200,{"Content-Type"=>"text/html"},[a.instance_eval(&b)]]}}}}
```

Breakdown:

``` ruby
  ['get','post','put','delete'].each do |method|
    define_method method do |path, &block|
      app.map( path ) do
        run ->(env){ [200, {'Content-Type'=>'text/html'}, [app.instance_eval( &block )]]}
      end
    end
  end
```


### Line 4

``` ruby
Tilt.mappings.map{|k,v|D.(k){|n,*o|$t||=(h=$u._jisx0301("hash, please");File.read(caller[0][/^[^:]+/]).scan(S){|a,b|h[a]=b};h);v[0].new(*o){n=="#{n}"?n:$t[n.to_s]}.render(a,o[0].try(:[],:locals)||{})}}
```

Breakdown:

``` ruby
  Tilt.mappings.each do |ext, engines|          # rename k to ext and v to engines
    define_method ext do |text, *args|          # rename n to text and o to args
      template = engines[0].new(*args) do
        text
      end
      locals = (args[0].respond_to?(:[]) ? args[0][:locals] : nil) || {}    # was o[0].try(:[],:locals)||{}
      template.render( app, locals )
    end
  end
```

Commentary: Almost Sinatra will define a method for every format so you can use, for example:

``` ruby
markdown "Strong emphasis, aka bold, with **asterisks** or __underscores__."
```

or

``` ruby
erb "Hello <%= name %>!", locals: { name: params['name'] }
```



###  Line 5

``` ruby
%w[set enable disable configure helpers use register].map{|m|D.(m){|*_,&b|b.try :[]}};END{Rack::Handler.get("webrick").run(a,Port:$z){|s|$r=s}}
```

Breakdown:

``` ruby
  # was END { ... }; change to run! method
  define_method 'run!' do
    Rack::Handler.get('webrick').run( app, Port:$port ) {|server| $server=server }
  end
```


### Line 6

``` ruby
%w[params session].map{|m|D.(m){q.send m}};a.use Rack::Session::Cookie;a.use Rack::Lock;D.(:before){|&b|a.use Rack::Config,&b};before{|e|q=Rack::Request.new e;q.params.dup.map{|k,v|params[k.to_sym]=v}}}
```

Breakdown:

``` ruby
  ['params','session'].each do |method|
    define_method method do
      req.send method
    end
  end

  app.use Rack::Session::Cookie
  app.use Rack::Lock
  app.use Rack::Config do |env|
    req = Rack::Request.new( env )
  end
end # Module.new
```


##  The Proof of the Pudding  - hello.rb

`samples/hello.rb`:

``` ruby
require 'almost-sinatra'

include $n    # include "anonymous" Almost Sinatra DSL module

get '/hello' do
  erb "Hello <%= name %>!", locals: { name: params['name'] }
end

get '/' do
  markdown <<EOS
## Welcome to Almost Sinatra

A six line ruby hack by Konstantin Haase.

Try:
- [Say hello!](/hello?name=Nancy)

Powered by Almost Sinatra (#{Time.now})
EOS
end


run!
```

Use

```
$ ruby -I ./lib ./samples/hello.rb
```


## Got Inspired? Build Your Own Microframework

- [New York, New York](https://github.com/alisnic/nyny)
- [Nancy](https://github.com/guilleiguaran/nancy)
- [Rum](https://github.com/chneukirchen/rum)
- [Cuba](https://github.com/soveran/cuba)
- [Roda](https://github.com/jeremyevans/roda)
- and many more


## Real World Case Study - webservice library - (Yet Another) HTTP JSON API (Web Service) Builder

Micro "framework" for building HTTP JSON APIs (about 100 lines of code).
Example:

``` ruby
get '/beer/:key' do
  Beer.find_by_key! params[ :key ]
end

get '/brewery/:key' do
  Brewery.find_by_key! params[ :key ]
end
```


## Links, Links, Links

- [Decoding Almost Sinatra](https://robm.me.uk/2013/12/13/decoding-almost-sinatra.html) by Rob Miller
- [Code Safari: Almost Sinatra, Almost Readable](http://www.sitepoint.com/code-safari-almost-sinatra-almost-readable/) by Xavier Shay
- [tilt library - let's build (yet another) micro web framework in less than 33 lines of code](http://planetruby.github.io/gems/tilt.html) by Gerald Bauer



## Bonus: Fun Almost Sinatra Obfuscation Hacks

"Calculate" the Sinatra Port 4567:

``` ruby
(Date.new.year + 145).abs     # Date.new.year always returns -4712, the default value for years
# => 4567
```

"Get" empty Hash (e.g. `{}`):

``` ruby
Date._jisx0301("hash, please")
# => {}
```
