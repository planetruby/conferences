# quik library and command line tool - Quick Starter Template Script Wizard - The Missing Code Generator and Project Scaffolder for Gems, Sinatra, Jekyll & More

github: [quikstart/quik](https://github.com/quikstart/quik),
rubygems: [quik](https://rubygems.org/gems/quik),
rdoc: [quik](http://rubydoc.info/gems/quik)




Q: How do you get started with creating a new gem?

- [A] From scratch ;-)
- [B] Using [bundler](http://bundler.io/v1.15/man/bundle-gem.1.html) with `$ bundle gem`
- [C] Using [quik](https://github.com/quikstart/gem-starter-template) with `$ quik new gem`
- [D] Using [hoe](https://github.com/seattlerb/hoe) with `$ sow` (incl. with hoe rake tasks gem)
- [E] Other (Please Tell).


Q: How do you get started with creating a new sinatra app or service?

- [A] From scratch ;-)
- [B] Using [padrino](http://padrinorb.com/guides/generators/projects) with `$ padrino g project`
- [C] Using [quik](https://github.com/quikstart/sinatra-starter-template) with `$ quik new sinatra`
- [D] Other (Please Tell).


Q: How do you get started with creating a new jekyll theme?

- [A] From scratch ;-)
- [B] Using [jekyll](http://jekyllrb.com/docs/themes/#creating-a-gem-based-theme) with `$ jekyll new-theme`
- [C] Using [quik](https://github.com/quikstart/jekyll-starter-theme) with `$ quik new jekyll`
- [D] Other (Please Tell).


## One Quik Starter to rule them all?

Let's welcome the quik library and command line tool.

The idea:  Many starter templates / boilerplates
are ready-to-fork GitHub repos.
Why not turn GitHub repos into quik starter templates?!
Let's do it in 1-2-3 steps.


## Step 1: Download Single-File Quik Starter (.ZIP) Archive

Did you know? You can download GitHub repos without git?
That is, download a single-file archive (.ZIP) -- gets (auto-)built by GitHub.

Example - `gem-starter-template.zip`:

```
lib/
  $filename$.rb
  $filename$/
    version.rb
test/
  helper.rb
  test_version.rb
.gitignore
HISTORY.md
Manifest.txt
README.md
Rakefile
```
(Source: [quikstart/gem-starter-template](https://github.com/quikstart/gem-starter-template))



## Step 2: Parameterize Files - Use a Template Language

- [A] Use Embedded Ruby (ERB)
- [B] Use Liquid
- [C] Other (Please Tell).


Example - `lib/linz/version.rb`:

``` ruby
module Linz

  MAJOR = 0
  MINOR = 0
  PATCH = 1
  VERSION = [MAJOR,MINOR,PATCH].join('.')

  def self.version
    VERSION
  end

  def self.banner
    "linz/#{VERSION} on Ruby #{RUBY_VERSION} (#{RUBY_RELEASE_DATE}) [#{RUBY_PLATFORM}]"
  end

end  # module Linz
```


Let's use a new (simpler) template language (e.g. `$name$`)!

Example - `lib/$filename$/version.rb`:

``` ruby
module $module$

  MAJOR = 0
  MINOR = 0
  PATCH = 1
  VERSION = [MAJOR,MINOR,PATCH].join('.')

  def self.version
    VERSION
  end

  def self.banner
    "$name$/#{VERSION} on Ruby #{RUBY_VERSION} (#{RUBY_RELEASE_DATE}) [#{RUBY_PLATFORM}]"
  end

end  # module $module$
```

(Source: [quikstart/gem-starter-template/template/lib/$filename$/version.rb](https://github.com/quikstart/gem-starter-template/blob/master/template/lib/%24filename%24/version.rb))


A New Meta Template Template Language. Why not ERB or Liquid?

- Simpler  -- works inside filenames too ;-) e.g. `lib/$filename$/version.rb`
- Shorter  -- less typing (plus: no worries about whitespace)

**Most Important:** "Orthogonal" to ERB and Liquid.
Lets you parameterize ERB or Liquid templates too - no need for escaping or "raw" blocks etc.


```
module $module$     | module <%= module %>  | module {{ module }}  | module Linz
  ...               |  ...                  |   ...                |   ...
end                 | end                   | end                  | end
```


## Step 3: What's Missing? All together Now - Automate with a Script

Let's use Ruby ;-) a with wizard mini language,
that is, a domain-specific language (DSL).

Example - `scripts/gem.rb`:

``` ruby
say "Hello from the gem quick starter wizard script"

name  = ask "Name of the gem", "hola"

def make_module( name )
   ...
end

module_name = ask "Module name of the gem", make_module( name )


## use template repo e.g. github.com/quikstart/gem-starter-template

use "quikstart/gem-starter-template"

config do |c|
  c.name     = name
  c.filename = name     ## for now assume name is 1:1 used as filename
  c.module   = module_name

  c.date     = Time.new.strftime("%Y-%m-%d")  ## e.g. use like $date$  => 2015-08-27
end
```

(Source: [quikstart/scripts/gem.rb](https://github.com/quikstart/scripts/blob/master/gem.rb))


Voila. That's it.



## Appendix: quik help  - Quik Starter Commands

```
$ quik --help      # or
$ qk -h
```

Resulting in:

```
NAME
    qk/quik - ruby quick starter template script wizard .:. the missing code generator

SYNOPSIS
    quik [global options] command [command options] [arguments...]

VERSION
    0.3.0

GLOBAL OPTIONS
    --help            - Show this message
    --verbose         - (Debug) Show debug messages
    --version         - Display the program version

COMMANDS
    list, ls, l - List ruby quick starter scripts
    new, n      - Run ruby quick starter script

    help        - Shows a list of commands or help for one command
```

### quik ls - List Quik Starter Wizards

Use:

```
$ quik list    # or
$ quik ls      # or
$ quik l       # or
$ qk l
```

Resulting in:

```
  1..gem        .:.  Gem Quick Starter Template
  2..gem-hoe    .:.  Gem Quick Starter Template (Hoe Classic Edition)
  3..sinatra    .:.  Sinatra Quick Starter Template
...
```


### quik new - New Wizard Quik Start

To run a quick starter template wizard script
to download and install (unzip/unpack) a template archive and configure
the code ready-to-use. Try:

```
$ quik new gem    # or
$ quik n gem      # or
$ qk n gem
```

This will download the `gem.rb` wizard script
from the [Scripts](https://github.com/quikstart/scripts) repo
and run through all steps e.g.:

```
Welcome, to the gem quick starter script.

Q: What's your gem's name? [hola]:   hello
Q: What's your gem's module? [Hola]: Hello

Thanks! Ready-to-go. Stand back.

  Downloading Gem Starter Template...
  Setting up Starter Template...
  ...
Done.
```

That's it. Now the gem starter code is ready in the `hello`
folder.



## Bonus: Meet Mr Hyde - Dr Jekyll's Dark Side - New Static Website Wizard Command

Q: What's **mrh/mrhyde** ★14 (github: [mrhydescripts/mrhyde](https://github.com/mrhydescripts/mrhyde))?

Static website quick starter script wizard .:. the missing jekyll command line tool.

Try:

```
$ mrhyde help
```

To run a static website quick starter wizard script
to download and install (unzip/unpack) a theme archive and configure
a static website ready-to-use. Try:

```
$ mrhyde new starter    # or
$ mrhyde n starter      # or
$ mrh n starter
```

This will download the `starter.rb` wizard script
from the [Mr. Hyde's Scripts](https://github.com/mrhydescripts/scripts) repo
and run through all steps.


```
Welcome, before setting up your site Mr. Hyde will ask you some questions.

Q: What's your site's title? [Your Site Title]:  Another Beautiful Static Website
Q: What's your name? [Henry Jekyll]: Edward Hyde
Q: Select your theme:
     1 - Starter
     2 - Bootstrap
     3 - Minimal
   Your choice (1-3)? [1]: 2

Thanks! Ready-to-go. Stand back twenty-five meters.
```


```
  Downloading Henry's Bootstrap Theme...
  Setting up Henry's Bootstrap Theme..
  ...
  Updating settings in _config.yml...
    title: "Another Beautiful Static Website"
    author.name: "Edward Hyde"
  ...
Done.
```

That's it. Now use:

```
$ cd starter
$ jekyll serve
```

And open up your new static website in your browser.
