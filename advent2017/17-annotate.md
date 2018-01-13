
# annotate library and command line tool - Annotate Your ActiveRecord Models with Comments about Your Database Table Structure


github: [ctran/annotate_models](https://github.com/ctran/annotate_models),
rubygems: [annotate](https://rubygems.org/gems/annotate),
rdoc: [annotate](http://rubydoc.info/gems/annotate)  




**Magic.**
ActiveRecord models can be as simple as:

``` ruby
class Beer < ActiveRecord::Base
end
```

or

``` ruby
class Brewery < ActiveRecord::Base
end
```

Some may find that's a little too much magic.
Where's the code? What attribute can you use?

By default ActiveRecord models require no information on the database tables wrapped
(it all works - thanks to convention over configuration, that is,
the class `Beer` (singular noun), for example, gets mapped to the table `beers` (plural noun)
and `Brewery` to `breweries` and so on.

**Best of both worlds.**
Less code is great and it's easy to update the model - just update the table -
there are no out-of-date setter and getters duplicated in the model, for example.
If you want the best of both worlds - you can always add the table columns to your models as comments.
Example:

``` ruby
# == Schema Information
#
# Table name: beers
#
#  id         :integer          not null, primary key
#  key        :string(255)      not null
#  title      :string(255)      not null
#  synonyms   :string(255)
#  web        :string(255)
#  since      :integer
#  seasonal   :boolean          default(FALSE), not null
#  limited    :boolean          default(FALSE), not null
#  kcal       :decimal
#  abv        :decimal
#  og         :decimal
#  srm        :integer
#  ibu        :integer
#  brewery_id :integer
#  brand_id   :integer
#  grade      :integer          default(4), not null
#  txt        :string(255)
#  txt_auto   :boolean          default(FALSE), not null
#  country_id :integer          not null
#  region_id  :integer
#  city_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Beer < ActiveRecord::Base
end
```

or

``` ruby
# == Schema Information
#
# Table name: breweries
#
#  id          :integer          not null, primary key
#  key         :string(255)      not null
#  title       :string(255)      not null
#  synonyms    :string(255)
#  address     :string(255)
#  since       :integer
#  closed      :integer
#  brewpub     :boolean          default(FALSE), not null
#  web         :string(255)
#  wikipedia   :string(255)
#  country_id  :integer          not null
#  region_id   :integer
#  city_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Brewery < ActiveRecord::Base
end
```

That looks like a lot of work if you type it in by hand.
If all the schema information is already stored in the database - why not automate the annotation procedure with a script in Ruby?


## What's the annotate library?

Let's thank [Dave Thomas](https://rubygems.org/profiles/pragdave1) {% avatar pragdave size=20 %}
and friends
who created the first annotate-models script back in 2006 as a Rails plugin
and let's thank [Cuong Tran](https://rubygems.org/profiles/ctran) {% avatar ctran size=20 %},
[Alex Chaffee](https://rubygems.org/profiles/alexch) {% avatar alexch size=20 %} and friends
who continue the tradition with a modern up-to-date annotate library
with more than 20+ releases since 2009 and 5+ million downloads.



**Not just for Rails.**
Out-of-the-box the annotate library includes
a command line tool named - surprise, surprise - annotate. Let's try it:

```
$ annotate -h
```

Will result in:

```
Please run annotate from the root of the project.
```

The annotate tool requires a Rakefile or Gemfile in the current working folder. Let's create an empty
Rakefile. Example:

`Rakefile`:

```
# beer.db Models Annotate Example
```

Now try:

```
$ annotate -h
```

Will result in:

```
Usage: annotate [options] [model_file]*
    -d, --delete                     Remove annotations from all model files or the routes.rb file
    -p, --position [before|after]    Place the annotations at the top (before) or the bottom (after) of the model/test/fixture/factory/routes file(s)
        --pc, --position-in-class [before|after]
                                     Place the annotations at the top (before) or the bottom (after) of the model file
        --pf, --position-in-factory [before|after]
                                     Place the annotations at the top (before) or the bottom (after) of any factory files
        --px, --position-in-fixture [before|after]
                                     Place the annotations at the top (before) or the bottom (after) of any fixture files
        --pt, --position-in-test [before|after]
                                     Place the annotations at the top (before) or the bottom (after) of any test files
        --pr, --position-in-routes [before|after]
                                     Place the annotations at the top (before) or the bottom (after) of the routes.rb file
    -r, --routes                     Annotate routes.rb with the output of 'rake routes'
    -v, --version                    Show the current version of this gem
    -m, --show-migration             Include the migration version number in the annotation
    -i, --show-indexes               List the table's database indexes in the annotation
    -s, --simple-indexes             Concat the column's related indexes in the annotation
        --model-dir dir              Annotate model files stored in dir rather than app/models
        --ignore-model-subdirects    Ignore subdirectories of the models directory
        --sort                       Sort columns alphabetically, rather than in creation order
    -R, --require path               Additional file to require before loading models, may be used multiple times
    -e [tests,fixtures,factories],   Do not annotate fixtures, test files, and/or factories
        --exclude
    -f [bare|rdoc|markdown],         Render Schema Infomation as plain/RDoc/Markdown
        --format
        --force                      Force new annotations even if there are no changes.
        --timestamp                  Include timestamp in (routes) annotation
        --trace                      If unable to annotate a file, print the full stack trace, not just the exception message.
    -I, --ignore-columns REGEX       don't annotate columns that match a given REGEX (i.e., `annotate -I '^(id|updated_at|created_at)'`
```

Looking good. Let's try to annotate the standalone beer.db models, that is, Beer, Brand, and Brewery.
Create a new `/lib` folder and add:

`beer.rb`:

``` ruby
class Beer < ActiveRecord::Base
end
```

`brand.rb`:

``` ruby
class Brand < ActiveRecord::Base
end
```

`brewery.rb`:

``` ruby
class Brewery < ActiveRecord::Base
end
```

And to wrap-up add the required setup code for an in-memory SQLite datebase to the empty Rakefile:

`Rakefile`:

``` ruby
# beer.db Models Annotate Example

def setup_in_memory_db
  require 'beerdb'

  ActiveRecord::Base.establish_connection(
      adapter:  'sqlite3',
      database: ':memory:'
  )

  BeerDb.create_all
end


setup_in_memory_db()
```

That's it. Get ready to annotate the models. Try:

```
$ annotate --model-dir lib
```

Resulting in:

```
Annotated (3): Beer, Brand, Brewery
```

Open up the `beer.rb`, `brand.rb` or `brewery.rb` scripts and Voila!
All the table schema information is now included.
To update the table schema information simply rerun annotate.
