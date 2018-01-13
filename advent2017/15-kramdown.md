
_The Future of Writing Structured Documents in Plain Text with "Lite" Markup Formatting Conventions in Markdown for Paragraphs, Headings, Bullet Lists, Numbered Lists, Code Blocks, Links and Much More_

# kramdown library and command line tool - Turn Easy-To-Read and Easy-To-Write (Structured) Plain Text with "Lite" Markup Formatting Conventions in Markdown into Web Pages or LaTeX Typesetting Documents


github: [gettalong/kramdown](https://github.com/gettalong/kramdown),
rubygems: [kramdown](https://rubygems.org/gems/kramdown),
rdoc: [kramdown](http://rubydoc.info/gems/kramdown) ++
more: [comments on reddit, please!](https://www.reddit.com/r/ruby/comments/7k1bq2/day_15_ruby_advent_calendar_2017_kramdown_turn/)


## What's Markdown?

Markdown is an easy-to-write and easy-to-read "lite" markup language in plain text
using formatting conventions -
used in email since the last century, for example - for structured documents
with paragraphs, headings, bullet lists, numbered lists, code block, links and much more
that you can convert "loss-less" to hypertext web pages, tex typesetting documents
and many other formats.


Example:

```
## What's `football.db`?

A free and open public domain football database & schema
for use in any (programming) language (e.g. uses plain datasets). Example:

    ### Teams

    barcelona, Barcelona|FC Barcelona|Fútbol Club Barcelona, BAR
    madrid,    Real Madrid|Real Madrid CF,                   RMD
    ...
```


becomes (converted to HTML):

``` html
<h2>What's <code>football.db</code>?</h2>

<p>A free and open public domain football database &amp; schema
for use in any (programming) language (e.g. uses plain datasets). Example:</p>

<pre><code>
### Teams

barcelona, Barcelona|FC Barcelona|Fútbol Club Barcelona, BAR
madrid,    Real Madrid|Real Madrid CF,                   RMD
...
</code></pre>
```

and becomes (converted to LaTeX):

``` latex
\subsection{What's \texttt{football.db}?}

A free and open public domain football database \& schema
for use in any (programming) language (e.g. uses plain datasets). Example:

\begin{verbatim}### Teams

barcelona, Barcelona|FC Barcelona|Fútbol Club Barcelona, BAR
madrid,    Real Madrid|Real Madrid CF,                   RMD
...
\end{verbatim}
```


## What's Kramdown?

Kramdown is a library and command line tool
that lets you convert plain text with formatting conventions in markdown (`.md, .mkdwn, .markdown`) to hypertext (`.html`), latex (`.html`) or unix manpages too.
Thanks to [Thomas Leitner](https://rubygems.org/profiles/gettalong) {% avatar gettalong size=20 %}
for publishing more than 50+ releases since 2009 - leading to today's version 1.16+
and more than 10 million downloads.



## Usage

Converting your plain text markup
to hypertext using kramdown is as easy as:

``` ruby
Kramdown::Document.new( '¡Barça, Barça, Baaarça!' ).to_html

# => "<p>¡Barça, Barça, Baaarça!</p>\n"
```

and to latex as easy as:

``` ruby
Kramdown::Document.new( '¡Barça, Barça, Baaarça!' ).to_latex

# => "<p>¡Barça, Barça, Baaarça!\n\n"
```




## Let's create another static site generator in five minutes

First lets create a new script and
let's add the `kramdown` library
plus the `find` standard library module to help us with finding files. Example:


`./sitegen.rb`:

``` ruby
require 'kramdown'
require 'find'
```

Next let's make a `_site` output folder.

``` ruby
SITE_PATH = './_site'

Dir.mkdir( SITE_PATH ) unless File.exist?( SITE_PATH )
```

Now let's add a `markdown` converter helper method.

``` ruby
def markdown( text )
  Kramdown::Document.new( text ).to_html
end
```

Finally, to wrap up let's loop over all files in the current working folder, that is, `.`
and generate hypertext (`.html`) documents in the `./site` folder
from the markdown (`.md`) source documents.

``` ruby
Find.find('.') do |path|
  if File.extname(path) == '.md'              # e.g. ./index.md => .md
    basename = File.basename(path, '.md')     # e.g. ./index.md => index

    File.open( "#{SITE_PATH}/#{basename}.html", 'w') do |file|
      file.write markdown( File.read( path ) )
    end
  end
end
```

That's it. Create a new markdown file. Example - `index.md`:

```
## What's `football.db`?

A free and open public domain football database & schema
for use in any (programming) language (e.g. uses plain datasets). Example:

    ### Teams

    barcelona, Barcelona|FC Barcelona|Fútbol Club Barcelona, BAR
    madrid,    Real Madrid|Real Madrid CF,                   RMD
    ...
```

Run the static site generation machinery e.g. type:

```
$ ruby ./sitegen.rb
```

That's it. Open up the web page `./_site/index.html` in your browser.


## Bonus: `kramdown` Command Line Tool

Note: The `kramdown` library ships with a command line tool named - suprise,
suprise - `kramdown`. Type in your shell:

```
$ kramdown -h
```

resulting in:

```
Command line options:

    -i, --input ARG
          Specify the input format: kramdown, github flavored markdown (GFM) or markdown
    -o, --output ARG
          Specify one or more output formats: html or latex
    -v, --version
          Show the version of kramdown
    -h, --help
          Show the help

kramdown options:

        --template ARG
          The name of an ERB template file that should be used to wrap the output
          or the ERB template itself.

        --[no-]auto-ids
          Use automatic header ID generation

        --[no-]auto-id-stripping
          Strip all formatting from header text for automatic ID generation

        --auto-id-prefix ARG
          Prefix used for automatically generated header IDs

        --[no-]transliterated-header-ids
          Transliterate the header text before generating the ID

        --[no-]parse-block-html
          Process kramdown syntax in block HTML tags

        --[no-]parse-span-html
          Process kramdown syntax in span HTML tags

        --link-defs ARG
          Pre-defines link definitions

        --footnote-nr ARG
          The number of the first footnote

        --toc-levels ARG
          Defines the levels that are used for the table of contents

        --line-width ARG
          Defines the line width to be used when outputting a document

        --latex-headers ARG
          Defines the LaTeX commands for different header levels

        --smart-quotes ARG
          Defines the HTML entity names or code points for smart quote output

        --header-offset ARG
          Sets the output offset for headers

        --[no-]hard-wrap
          Interprets line breaks literally

        --syntax-highlighter ARG
          Set the syntax highlighter

        --syntax-highlighter-opts ARG
          Set the syntax highlighter options

        --math-engine ARG
          Set the math engine

        --math-engine-opts ARG
          Set the math engine options
```

Yes, it's well documented  - help output shortened :-). Welcome to the wonders of kramdown
and the future of writing structured documents in plain text with markup formatting conventions in markdown.


More kramdown goodies. See the [Awesome Kramdown](https://github.com/mundimark/awesome-kramdown) collection / page.
