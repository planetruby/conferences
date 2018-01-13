_Works w/ any text editor - future-proof text formats - the free writer's command line tool suite_

# officetxt library and command line tools - Write Notes, Articles, Journals, Presentations, Websites, Blogs, Manuscripts, Books & More


github: [officetxt/officetxt](https://github.com/officetxt/officetxt),
rubygems: [officetxt](https://rubygems.org/gems/officetxt),
rdoc: [officetxt](http://rubydoc.info/gems/officetxt)  



## What's Office.TXT?

It's an all-in-one free write's command line tool suite.
Command line tools include:

- `officetxt` (`txt`)
- `journaltxt` (`jo`)
- `jekyll`
- `drjekyll` (`drj`)
- `mrhyde` (`mrh`)
- `octopod`
- `slideshow`
- `pluto`
- `rougify`   
- `kramdown`
- `w2m`   
- `quik` (`qk`)


Use

```
$ officetxt
-or-
$ txt
```

to listed included / installed tools e.g. resulting in:

```
Welcome to officetxt/0.1.0:

Tool versions installed:
  journaltxt/1.0.1
  jekyll/3.5.0
    jekyll-import/0.12.0
    jekyll-avatar/0.4.2
    jekyll-planet/0.2.1
  mrhyde/0.1.1
  drjekyll/1.0.1
  octopod/0.9.0
  slideshow/3.1.0
  pluto/1.2.3
  rouge/1.11.1
  kramdown/1.13.2
  word-to-markdown/1.1.7
  quik/0.3.0
```


### What's Journal.TXT?

Reads Journal.TXT and writes out (auto-builds) a blog (w/ Jekyll posts etc.);
learn more [journaltxt/journaltxt »](https://github.com/journaltxt/journaltxt)

Try on the command line:

```
$ journaltxt --help
  -or-
$ jo --help
```

resulting in:

```
Usage: journaltxt [OPTS]
    -v, --[no-]verbose               Show debug messages
    -o, --output=PATH                Output path (default: .)
    -n, --name=NAME                  Journal name (default: Journal)
        --[no-]date                  Add date to page title (default: true)
    -h, --help                       Prints this help
```


### What's Slide Show (S9)?

Write your slides / talks / presentations in (plain) text with markdown formatting conventions;
free web alternative to PowerPoint and Keynote; learn more [slideshow-s9 »](http://slideshow-s9.github.io)

Try on the command line:

```
$ slideshow help
```

resulting in:

```
NAME
    slideshow - Slide Show (S9) - a free web alternative to PowerPoint and Keynote in Ruby

SYNOPSIS
    slideshow [global options] command [command options] [arguments...]

GLOBAL OPTIONS
    -c, --config=PATH - Configuration Path (default: Z:/.slideshow)
    --help            - Show this message
    -q, --quiet       - Only show warnings, errors and fatal messages
    --version         - Display the program version

COMMANDS
    about, a           - (Debug) Show more version info
    build, b           - Build slideshow
    help               - Shows a list of commands or help for one command
    install, i         - Install template pack
    list, ls, l        - List installed template packs
    new, n             - Generate quick starter sample
    plugins, plugin, p - (Debug) List plugin scripts in load path
    update, u          - Update shortcut index for template packs 'n' plugins
```

### What's Dr Jekyll?

Lets you manage static website theme packages;
learn more [drjekyllthemes/drjekyll »](https://github.com/drjekyllthemes/drjekyll)

Try on the command line:

```
$ drjekyll help
  -or-
$ drj help
```

resulting in:

```
NAME
    drjekyll - jekyll command line tool .:. the missing static site package manager

SYNOPSIS
    drjekyll [global options] command [command options] [arguments...]

GLOBAL OPTIONS
    --help    - Show this message
    --version - Display the program version

COMMANDS
    download, dl, d, get, g - (Debug) Step 1: Download theme; .zip archive saved
                              in working folder (./)
    help                    - Shows a list of commands or help for one command
    list, ls, l             - List themes
    new, n                  - Download 'n' setup (unzip/unpack) theme
    unpack, pk, p, setup, s - (Debug) Step 2: Setup (unzip/unpack) theme; uses
                              saved .zip archive in working folder (./)
```

## What's Mr Hyde?

Lets you run a static website quick starter wizard script
to download and install (unzip/unpack) a theme archive and configure a static website ready-to-use;
learn more [mrhydescripts/mrhyde »](https://github.com/mrhydescripts/mrhyde)


Try on the command line:

```
$ mrhyde help
  -or-
$ mrh help
```

resulting in:

```
NAME
    mrhyde - jekyll command line tool .:. the static site quick starter script wizard

SYNOPSIS
    mrhyde [global options] command [command options] [arguments...]

GLOBAL OPTIONS
    --help            - Show this message
    --test, --dry_run - (Debug) Dry run; run script in simulation for testing
    --version         - Display the program version

COMMANDS
    help   - Shows a list of commands or help for one command
    new, n - Run static site quick starter script
```


### What's Octopod?

Write your show notes in (plain) text and publish (and sync)
your podcasts / radio talk shows; learn more [jekyll-octopod »](https://jekyll-octopod.github.io)

Brought to you by:

{% include avatar.html handle="haslinger" name="Stefan Haslinger" %}


Try on the command line:

```
$ octopod --help
```

resulting in:

```
Octopod - podcast publishing for geeks

Basic Command Line Usage:
  Standard Jekyll commands:
    octopod b[uild]                                                # . -> ./_site
    octopod build <path to write generated site>                   # . -> <path>
    octopod build <path to source> <path to write generated site>  # <path> -> <path>
    octopod import <importer name> <options>                       # imports posts using named import script
    octopod setup                                                  # Setup blog to become podcast-aware, copy assets and default config
    octopod s[erver]                                               # Starts the server

  Additional Octopod commands:
    octopod episode                                           # adds a template for a new episode
    octopod deploy                                            # deploys your site

  See 'octopod <command> --help' for more information on a specific command.
```

### What's Pluto?

Lets you auto-build web pages from published web feeds; learn more [feedreader »](http://feedreader.github.io)


Try on the command line:

```
$ pluto help
```

resulting in:

```
NAME
    pluto - another planet generator (lets you build web pages from published web feeds)

SYNOPSIS
    pluto [global options] command [command options] [arguments...]

GLOBAL OPTIONS
    -c, --config=PATH - Configuration Path (default: Z:/.pluto)
    --help            - Show this message
    -q, --quiet       - Only show warnings, errors and fatal messages
    --version         - Display the program version

COMMANDS
    about, a      - (Debug) Show more version info
    build, b      - Build planet
    fetch, f      - Fetch feeds
    help          - Shows a list of commands or help for one command
    install, i    - Install template pack
    list, ls, l   - List installed template packs
    merge, m      - Merge planet template pack
    update, up, u - Update planet feeds
```


### What's Rouge?

Lets you highlight your code; styles are compatible with pygments;
learn more [jneen/rouge »](https://github.com/jneen/rouge)

Brought to you by:

{% include avatar.html handle="jneen" name="Jeanine Adkisson" %}


Try on the command line:

```
$ rougify help
```

resulting in:

```
usage: rougify [command] [args...]

where <command> is one of:
        highlight       highlight code
        help            print help info
        style           print CSS styles
        list            list available lexers
        version         print the rouge version number

See `rougify help <command>` for more info.
```


### What's Kramdown?

Lets you convert text with markdown formatting conventions to
hypertext markup language (html) or latex; learn more [kramdown »](https://kramdown.gettalong.org)

Brought to you by:

{% include avatar.html handle="gettalong" name="Thomas Leitner" %}



Try on the command line:

```
$ kramdown --help
```

resulting in (note: shortened all options):

```
Command line options:

    -i, --input ARG
          Specify the input format: kramdown (default), html, GFM or markdown
    -o, --output ARG
          Specify one or more output formats separated by commas: html (default),
          kramdown, latex, pdf, man or remove_html_tags
    -v, --version
          Show the version of kramdown
    -h, --help
          Show the help

kramdown options:

        --auto-id-prefix ARG
          Prefix used for automatically generated header IDs

        --[no-]auto-ids
          Use automatic header ID generation

        --entity-output ARG
          Defines how entities are output

        --footnote-backlink ARG
          Defines the text that should be used for the footnote backlinks

        --footnote-nr ARG
          The number of the first footnote

        --gfm-quirks ARG
          Enables a set of GFM specific quirks

        --header-offset ARG
          Sets the output offset for headers

        --latex-headers ARG
          Defines the LaTeX commands for different header levels

        --line-width ARG
          Defines the line width to be used when outputting a document

        --link-defs ARG
          Pre-defines link definitions

        --math-engine ARG
          Set the math engine

        --smart-quotes ARG
          Defines the HTML entity names or code points for smart quote output

        --syntax-highlighter ARG
          Set the syntax highlighter

        --toc-levels ARG
          Defines the levels that are used for the table of contents

        --[no-]transliterated-header-ids
          Transliterate the header text before generating the ID
```


### What's Word-to-Markdown?

Lets you liberate content from Microsoft Word documents;
learn more [benbalter/word-to-markdown »](https://github.com/benbalter/word-to-markdown)

Brought to you by:

{% include avatar.html handle="benbalter" name="Ben Balter" %}


Try on the command line:

```
$ w2m
```

resulting in:

```
Usage: w2m path/to/document.docx
```


### What's Quik?

Lets you run quick starter template scripts for scaffolding projects;
learn more [quikstart/quik »](https://github.com/quikstart/quik)

Try on the command line:

```
$ quik help
  -or-
$ qk help
```

resulting in:

```
NAME
    quik - quick starter template script wizard .:. the missing project scaffolder

SYNOPSIS
    quik [global options] command [command options] [arguments...]

GLOBAL OPTIONS
    --help            - Show this message
    --test, --dry_run - (Debug) Dry run; run script in simulation for testing
    --version         - Display the program version

COMMANDS
    help        - Shows a list of commands or help for one command
    list, ls, l - List quick starter scripts
    new, n      - Run quick starter script
```
