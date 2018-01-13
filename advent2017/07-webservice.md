_Get a free wiener lager, welsh red ale or kriek lambic beer delivered to your home (computer) in JSON and much much more_

# webservice library - Script HTTP JSON APIs (Web Services); Load (Micro) Web Services At-Runtime and More.

github: [rubylibs/webservice](https://github.com/rubylibs/webservice),
rubygems: [webservice](https://rubygems.org/gems/webservice),
rdoc: [webservice](http://rubydoc.info/gems/webservice)



## What's the webservice library?


The webservice library lets you script HTTP JSON APIs also known as
web services or microservices in classy [Sinatra 2.0](https://github.com/sinatra/sinatra)-style `get` / `post` methods
with [Mustermann 1.0](https://github.com/sinatra/mustermann) route / url pattern matching.


### Dynamic Example

You can load web services at-runtime from files using `Webservice.load_file`.
Example:

```ruby
# service.rb

get '/' do
  'Hello, world!'
end
```

and

```ruby
# server.rb

require 'webservice'

App = Webservice.load_file( './service.rb' )
App.run!
```

and to run type

```
$ ruby ./server.rb
```


### Classic Example

```ruby
# server.rb

require 'webservice'

class App < Webservice::Base
  get '/' do
    'Hello, world!'
  end
end

App.run!
```
and to run type

```
$ ruby ./server.rb
```


### Rackup Example

Use `config.ru` and `rackup`. Example:

```ruby
# config.ru

require `webservice`

class App < Webservice::Base
  get '/' do
    'Hello, world!'
  end
end

run App
```

and to run type

```
$ rackup      # will (auto-)load config.ru
```

Note: `config.ru` is a shortcut (inline)
version of `Rack::Builder.new do ... end`:

```ruby
# server.rb

require 'webservice'

class App < Webservice::Base
  get '/' do
    'Hello, world!'
  end
end

builder = Rack::Builder.new do
  run App
end

Rack::Server.start builder.to_app
```

and to run type

```
$ ruby ./server.rb
```



## Bonus - "Real World" Examples

See

[**`beerkit / beer.db.service`**](https://github.com/beerkit/beer.db.service) -
beer.db HTTP JSON API (web service) scripts e.g.

```ruby
get '/beer/(r|rnd|rand|random)' do    # special keys for random beer
  Beer.rnd
end

get '/beer/:key'
  Beer.find_by! key: params['key']
end

get '/brewery/(r|rnd|rand|random)' do    # special keys for random brewery
  Brewery.rnd
end

get '/brewery/:key'
  Brewery.find_by! key: params['key']
end

...
```


[**`worlddb / world.db.service`**](https://github.com/worlddb/world.db.service) -
world.db HTTP JSON API (web service) scripts

```ruby
get '/countries(.:format)?' do
  Country.by_key.all    # sort/order by key
end

get '/cities(.:format)?' do
  City.by_key.all       # sort/order by key
end

get '/tag/:slug(.:format)?' do   # e.g. /tag/north_america.csv
  Tag.find_by!( slug: params['slug'] ).countries
end

...
```


[**`sportdb / sport.db.service`**](https://github.com/sportdb/sport.db.service) -
sport.db (football.db) HTTP JSON API (web service) scripts
