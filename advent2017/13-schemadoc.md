_Connects with ActiveRecord works with SQLite, PostgreSQL, MySQL, MariaDB, ..._

# schemadoc library and command line tool - Auto-generate your SQL database schema documentation for tables, columns, symbols A-Z, etc; use your own (static) jekyll themes and much more


github: [schemadoc/schemadoc](https://github.com/schemadoc/schemadoc),
rubygems: [schemadoc](https://rubygems.org/gems/schemadoc),
rdoc: [schemadoc](http://rubydoc.info/gems/schemadoc)




## What's schemadoc?

The schemadoc library includes a ready-to-use command line tool named - surprise,
surprise - schemadoc that lets you auto-generate your database schema documentation
for tables, columns, and more.

Try:

```
$ schemadoc --help
```

resulting in:

```
schemadoc 1.0.0 - Lets you document your database tables, columns, etc.

Usage: schemadoc [options]
    -o, --output PATH            Output path (default is '.')
    -v, --verbose                Show debug trace

Examples:
  schemadoc                # defaults to ./schemadoc.yml
  schemadoc football.yml
```


**Overview.** The schemadoc tool connects to your database (e.g. SQLite, PostgreSQL, etc.)
and writes out the schema info in `database.json`

``` json
{
  "schemas": [
    {
      "name": "football",
      "tables": [
        {
          "name": "alltime_standing_entries",
          "columns": [
            {
              "name": "id",
              "type": "integer",
              "default": null,
              "null": false
            },
            {
              "name": "alltime_standing_id",
              "type": "integer",
              "default": null,
              "null": false
            },
            {
              "name": "team_id",
              "type": "integer",
              "default": null,
              "null": false
            },
...
```

and also builds an A-Z symbols index stored in `symbols.json`.

``` json
{
    "name": "A",
    "tables": [
      "alltime_standing_entries",
      "alltime_standings",
      "assocs",
      "assocs_assocs"
    ],
    "columns": [
      {
        "name": "abbr",
        "tables": [
          "regions"
        ]
      },
      {
        "name": "address",
        "tables": [
          "grounds",
          "teams"
        ]
      },
...
```

Drop the JSON documents in the `_data/` folder for your static
site theme (template pack) and let Jekyll (or GitHub Pages) do the rest.

**Examples in the real world.**  See the [football.db](http://openfootball.github.io/schema/)
or [beer.db](http://openbeer.github.io/schema/) for live examples.



## Getting Started w/ schemadoc

Let's document the football.db SQLite version in three steps:

- Step 1: Let's create the football.db
- Step 2: Let's write out the schema info in JSON
- Step 3: Let's generate a static schema documentation site


### Step 1: Let's create the football.db

First let's create the football.db itself. Pull in the `sportdb-models` library
and use the built-in "auto-migrate" method `SportDb.create_all` that will create all database tables.
Example:

`mkfootball.rb`:

``` ruby
require 'logger'
require 'sportdb/models'      # use $ gem install sportdb-models

DB_CONFIG = {
  adapter: 'sqlite3',
  database: './football.db'
}

ActiveRecord::Base.logger = Logger.new( STDOUT )
ActiveRecord::Base.establish_connection( DB_CONFIG )

SportDb.create_all

puts 'Done.'
```

Run the script:

```
$ ruby ./makfootball.rb
```

Now you've got an empty football.db with many many tables. Let's document the database schema(ta).


###  Step 2: Let's write out the schema info in JSON

The schemadoc command line tool requires a configuration file, that is, `/schemadoc.yml`
that lists the connection settings and the schemas (such as football, world, and the works.) Example:

`schemadoc.yml`:

``` yaml
## connection spec

database:
  adapter:  sqlite3
  database: ./football.db


## main tables

football:
  name: Football

## world tables

world:
  name: World
  tables:
    - continents
    - countries
    - regions
    - cities
    - places
    - names
    - langs
    - usages

## works tables

works:
  name: The Works
  tables:
     - logs
     - props
     - tags
     - taggings
```

Now run the schemadoc tool:

```
$ schemadoc
```

and you will end-up with two JSON files, that is, `database.json` and `symbols.json`.



### Step 3: Let's generate a static schema documentation site

Get a copy of the [`schemadoc/schemadoc-theme`](https://github.com/schemadoc/schemadoc-theme) static website theme
and drop (copy) the two JSON files, that is, `database.json` and `symbols.json`
into the `_data/` folder. Change the site settings in `_config.yml` and run:

```
$ jekyll build
```

That's it. Open up in your browser the `./_site/index.html` page.
Enjoy your databasse schema documentation.
