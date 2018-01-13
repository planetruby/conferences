Commands, Commands, Commands - Talk to Your Computer (Bots) in the Shell in Text - Ready?


# gli library - Add Git-Like Interfaces (GLI) to Your Awesome Command-Line Tools

github: [davetron5000/gli](https://github.com/davetron5000/gli),
rubygems: [gli](https://rubygems.org/gems/gli),
rdoc: [gli](http://rubydoc.info/gems/gli)  



## What's `OptionParser`?

Ruby ships with a built-in class, that is, `OptionParser`
that lets you define and parse options for your command line tool.
Let say you're building a command line tool for the open beer database
and as options you want to offer a switch to turn on debug
messages e.g. `-v` or `--verbose` and
another switch to change the database name
from the default `beer.db` to lets say `lager.db`
using `-n lager.db` or `--dbname=lager.db`.

A minimal version with the built-in `OptionParser` looks like:

``` ruby
require 'optparse'

config = { name: 'beer.db' }

parser = OptionParser.new do |opts|
  opts.banner = "Usage: beerdb [OPTS]"

  opts.on("-v", "--verbose", "Show debug messages") do |verbose|
    config[:verbose] = verbose
  end

  opts.on("-n", "--dbname=NAME", "Database name (default: beer.db)") do |name|
    config[:name] = name
  end

  opts.on("-h", "--help", "Prints this help") do
    puts opts
    exit
  end
end

parser.parse!(ARGV)

p config
p ARGV
```

Try

```
$ ruby beerdb.rb --help
```

Resulting in:

```
Usage: beerdb [OPTS]
    -v, --verbose          Show debug messages
    -n, --dbname=NAME      Database name (default: beer.db)
    -h, --help             Prints this help
```

or try:

```
$ ruby beerdb.rb --verbose --dbname=lager   # or
$ ruby beerdb.rb -vnlager
```

Resulting in:

```
{:name=>"lager", :verbose=>true}
[]
```

Note: The `OptionParser#parse!` method modifies `ARGV`, that is,
removes all command-line options (such as `--verbose`
and `--dbname=lager`) from ARGV, thus, the argument vector ends up empty `[]`).


The `OptionParser` works great if all you need is a couple of options
for your little command-line tool. Now imagine building a command-line tool
like git - the stupid content tracker - that offers thousands of options. Let's try:

```
$ git help
```

Resulting in:

```
usage: git [--version] [--exec-path[=GIT_EXEC_PATH]] [--html-path]
           [-p|--paginate|--no-pager] [--no-replace-objects]
           [--bare] [--git-dir=GIT_DIR] [--work-tree=GIT_WORK_TREE]
           [--help] COMMAND [ARGS]

The most commonly used git commands are:
   add        Add file contents to the index
   bisect     Find by binary search the change that introduced a bug
   branch     List, create, or delete branches
   checkout   Checkout a branch or paths to the working tree
   clone      Clone a repository into a new directory
   commit     Record changes to the repository
   diff       Show changes between commits, commit and working tree, etc
   fetch      Download objects and refs from another repository
   grep       Print lines matching a pattern
   init       Create an empty git repository or reinitialize an existing one
   log        Show commit logs
   merge      Join two or more development histories together
   mv         Move or rename a file, a directory, or a symlink
   pull       Fetch from and merge with another repository or a local branch
   push       Update remote refs along with associated objects
   rebase     Forward-port local commits to the updated upstream head
   reset      Reset current HEAD to the specified state
   rm         Remove files from the working tree and from the index
   show       Show various types of objects
   status     Show the working tree status
   tag        Create, list, delete or verify a tag object signed with GPG
```

Git not only offers options but also offers commands and options for commands
and commands for commands and so on. For example,
to see the options and commands for the `remote` command try:

```
$ git help remote
```

Resulting in:

```
NAME
       git-remote - manage set of tracked repositories

SYNOPSIS
       git remote [-v | --verbose]
       git remote add [-t <branch>] [-m <master>] [-f] [--mirror] <name> <url>
       git remote rename <old> <new>
       git remote rm <name>
       git remote set-head <name> (-a | -d | <branch>)
       git remote set-url [--push] <name> <newurl> [<oldurl>]
       git remote set-url --add [--push] <name> <newurl>
       git remote set-url --delete [--push] <name> <url>
       git remote [-v | --verbose] show [-n] <name>
       git remote prune [-n | --dry-run] <name>
       git remote [-v | --verbose] update [-p | --prune] [group | remote]...

DESCRIPTION
       Manage the set of repositories ("remotes") whose branches you track.

OPTIONS
       -v, --verbose
           Be a little more verbose and show remote url after name. NOTE: This
           must be placed between remote and subcommand.

COMMANDS
       With no arguments, shows a list of existing remotes. Several
       subcommands are available to perform operations on the remotes.

       add
           Adds a remote named <name> for the repository at <url>. The command
           git fetch <name> can then be used to create and update
           remote-tracking branches <name>/<branch>.

           With -f option, git fetch <name> is run immediately after the
           remote information is set up.

           With -t <branch> option, instead of the default glob refspec for
           the remote to track all branches under $GIT_DIR/remotes/<name>/, a
           refspec to track only <branch> is created. You can give more than
           one -t <branch> to track multiple branches without grabbing all
           branches.
           ...
```

If you feel adventurous you might build your own git-like command parser ontop of the
built-in option parser. Example:

``` ruby
include 'optparse'

config = {}

parser = OptionParser.new do |opts|
  opts.banner = "Usage: beerdb [GLOBAL_OPTS] COMMAND [OPTS]"

  opts.on("-v", "--verbose", "Show debug messages") do |verbose|
    config[:verbose] = verbose
  end

  opts.on("-n", "--dbname=NAME", "Database name (default: beer.db)") do |name|
    config[:name] = name
  end
end

parser.parse!(ARGV)

command = ARGV.shift

case command do
when 'new':
  # do something
when 'build'
  # do something
when 'serve'
  # do something
else
  # print help
end
```

While a start - it's missing options for commands
or help messages or nested command and on and on.


## What's the gli (Git-Like Interfaces) library?

Let's thank [David Bryant Copeland](https://rubygems.org/profiles/davetron5000)
{% avatar davetron5000 size=20 %}
who has done all the work and packed up (yet another) command parser
built ontop of OptionParser in an easy-to-(re)use package
offering it's very own mini-language (domain-specific language)
to let you define your commands (or even commands of commands of commands)
in plain old ruby.

Example:

``` ruby
program_desc 'beer.db command line tool'
version      '2.1.1'

### global options

desc 'Database path'
arg_name 'PATH'
default_value opts.db_path
flag [:d, :dbpath]

desc 'Database name'
arg_name 'NAME'
default_value opts.db_name
flag [:n, :dbname]

desc 'Show debug messages'
switch [:verbose], negatable: false

### commands

desc "Build DB w/ quick starter Datafile templates"
arg_name 'NAME'           # optional setup profile name
command [:new,:n] do |c|
  c.action do |g,o,args|

    # do something here

  end
end # command setup


desc "Build DB (download/create/read); use ./Datafile - zips get downloaded to ./tmp"
command [:build,:b] do |c|
  c.action do |g,o,args|

    # do something here

  end
end # command build

...
```

If you run the "real-world" beerdb command-line tool
built using the git-like interfaces (gli) machinery:

```
$ beerdb help
```

results in:

```
NAME
    beerdb - beer.db command line tool

SYNOPSIS
    beerdb [global options] command [command options] [arguments...]

GLOBAL OPTIONS
    -d, --dbpath=PATH - Database path (default: .)
    -n, --dbname=NAME - Database name (default: beer.db)
    -q, --quiet       - Only show warnings, errors and fatal messages
    --verbose         - Show debug messages
    --version         - Display the program version
    --help            - Show this message

COMMANDS
    build, b      - Build DB (download/create/read); use ./Datafile - zips get
                    downloaded to ./tmp
    create        - Create DB schema
    download, dl  - Download datasets; use ./Datafile - zips get downloaded to
                    ./tmp
    help          - Shows a list of commands or help for one command
    load, l       - Load beer fixtures
    logs          - Show logs
    new, n        - Build DB w/ quick starter Datafile templates
    props         - Show props
    read, r       - Read datasets; use ./Datafile - zips required in ./tmp
    serve, server - Start web service (HTTP JSON API)
    setup, s      - Create DB schema 'n' load all world and beer data
    stats         - Show stats
```

and

```
$ beerdb help serve
```

results in:

```
NAME
    serve - Start web service (HTTP JSON API)

SYNOPSIS
    beerdb [global options] serve [command options]

COMMAND OPTIONS
    -p, --port=PORT - Port to listen on (default: 6666)
    -h, --host=HOST - Host to bind to (default: 127.0.0.1)
```

Got interested?  David Bryant Copeland again has you covered and
documented the gli library, has written a tutorial titled [Introduction to GLI](http://naildrivin5.com/blog/2013/12/02/introduction-to-gli.html)
and even an book
titled - surprise, surprise - [Build Awesome Command-Line Applications in Ruby](https://pragprog.com/book/dccar2/build-awesome-command-line-applications-in-ruby-2).



## Bonus:  Quick Starter Code Templates with `gli init`

To get you started quicker the gli gem ships with its own awesome command-line tool
built with gli. Try:

```
$ gli help
```

resulting in:

```
NAME
    gli - create scaffolding for a GLI-powered application

SYNOPSIS
    gli [global options] command [command options] [arguments...]

GLOBAL OPTIONS
    -n             - Dry run; dont change the disk
    -r, --root=arg - Root dir of project (default: .)
    -v             - Be verbose
    --version      - Display the program version
    --help         - Show this message

COMMANDS
    help           - Shows a list of commands or help for one command
    init, scaffold - Create a new GLI-based project
```

Now run `gli init beerdb` or using the alias `gli scaffold beerdb` and you
will get ready-to-use and read-to-run code:

```
Creating dir ./beerdb/lib...
Creating dir ./beerdb/bin...
Creating dir ./beerdb/test...
Created ./beerdb/bin/beerdb
Created ./beerdb/README.rdoc
Created ./beerdb/beerdb.rdoc
Created ./beerdb/beerdb.gemspec
Created ./beerdb/test/default_test.rb
Created ./beerdb/test/test_helper.rb
Created ./beerdb/Rakefile
Created ./beerdb/Gemfile
Created ./beerdb/features
Created ./beerdb/lib/beerdb/version.rb
Created ./beerdb/lib/beerdb.rb
```
