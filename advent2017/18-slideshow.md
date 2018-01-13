
_Free Web Alternative to PowerPoint and KeyNote - Write Your Talks in (Structured) Text - Many Theme Packs (Jekyll-Compatible) Incl. Reveal.js, Bespoke.js, Impress.js, Shower.js, S6 and More_

# slideshow (s9) library and command line tool - Write Your Slides / Talks / Presentations in (Structured) Text with Formatting Conventions in Markdown - Kramdown, Really ;-); Build (Static) Webpages w/ (Jekyll-Compatible) Theme Packs


github: [slideshow-s9/slideshow](https://github.com/slideshow-s9/slideshow),
rubygems: [slideshow](https://rubygems.org/gems/slideshow),
rdoc: [slideshow](http://rubydoc.info/gems/slideshow) ++
more: [comments on reddit, please!](https://www.reddit.com/r/ruby/comments/7kmlho/day_18_ruby_advent_calendar_2017_slideshow_s9/)



## What's Slideshow (S9)?

A command line tool and library that lets you build slideshows
from your notes written in plain text with formatting conventions in markdown - kramdown, really ;-) e.g. incl. tables, definition lists, footnotes, attribute lists, auto ids, and much more.
The slideshow (S9) project also collects and welcomes (Jekyll-compatible) themes 
and ships "out-of-the-box" with built-in support for "loss-free" gradient vector graphics backgrounds.



## Quick Starter Kit

Let's get started with the [Slideshow (S9) Quick Starter Kit](https://github.com/slideshow-s9/slideshow-starter).
A first sample talk - `sample1.text`:

```
title:     Habits
author:    Ruby Rubens
date:      December 18, 2017


%%%%
% use fullscreen css styles for a "section" slide

{:.fullscreen}
# In the morning


%%%%%%%
% use heading 1s or heading 2s for starting new slides

# Getting up

- Turn off alarm
- Get out of bed

# Breakfast

- Eat eggs
- Drink coffee


{:.fullscreen}
# In the evening


# Dinner

- Eat spaghetti
- Drink wine
- Browse slide show


%%%%%%%
% use the !SLIDE directive for slides without headings

!SLIDE

![](i/slideshow.png)


%%%%%%%%%%%
% let's wrap up; another slide

# Going to sleep

- Get in bed
- Count sheep
```


## Step 0: Setup Templates Packs & Plugins

Use the slideshow (S9) command line tool to download (fetch) the template pack and plugin helpers:

```
$ slideshow install s6blank        # fetch s6 blank template pack
$ slideshow install plugins        # fetch (standard) plugin helpers
```


To double check what template packs and plugins you have installed try:

```
$ slideshow list
```

resulting in:

```
Installed plugins in search path
    [1] plugins/*.{txt.plugin,plugin.txt}
    [2] plugins/*/*.{txt.plugin,plugin.txt}
    [3] ~/.slideshow/plugins/*.{txt.plugin,plugin.txt}
    [4] ~/.slideshow/plugins/*/*.{txt.plugin,plugin.txt}
  include:
       analytics (~/.slideshow/plugins/analytics/analytics.txt.plugin)
        snippets (~/.slideshow/plugins/snippets/snippets.txt.plugin)
          tables (~/.slideshow/plugins/tables/tables.txt.plugin)

Installed template packs in search path
    [1] templates/*.txt
    [2] templates/*/*.txt
    [3] node_modules/*/*.txt
    [4] ~/.slideshow/templates/*.txt
    [5] ~/.slideshow/templates/*/*.txt
  include:
         s6blank (~/.slideshow/templates/s6blank/s6blank.txt)
```


## Build Instructions

Use the slideshow (S9) command line tool to build
a (static) web page (e.g. `sample1.html`)
that is an all-in-one-page handout and a live slide show all at once.

```
$ slideshow build sample1.text

=> Preparing slideshow 'sample1.html'...
=> Done.
```


That's it. Open up your slide show `sample1.html` in your browser
(Firefox, Chrome, Opera, Safari, Edge and others) and hit F11 to switch into full screen projection
and hit the space bar or the right arrow, down arrow or page down key to flip through your slides.



## Bonus: impress.js - Slideshow (S9) Template Pack

The [impress.js](https://github.com/impress/impress.js) package by Bartek Szopka (aka bartaz)
bundled up into a slideshow (S9) template pack
lets you write your slides
in text with formmating conventions in markdown and lets you use filters and helpers for adding comments, macros,
includes, syntax highlighters and much more.

Note, the package is configured to use the following headers in `slides.html`:

    author: Your Name Here
    title: Your Slide Show Title Here


### Try It Yourself - How To Use the impress.js Template Pack

If you want to try it yourself, install (fetch) the new template pack. Type the command:

    $ slideshow install impress.js

Or as an alternative clone the template pack using `git`. Type the commands:

    $ cd ~/.slideshow/templates
    $ git clone https://github.com/slideshow-templates/slideshow-impress.js

To check if the new template got installed, use the `list` command:

    $ slideshow list

Listing something like:

    Installed templates include:
       impress.js (~/.slideshow/templates/impress.js/impress.js.txt)

Tip: To get started use the included quick starter sample. Type the command:

    $ slideshow new -t impress.js

Now you will have a copy of the impress.js Quick Starter sample
(that is, [`impress.js.text`](https://raw.github.com/slideshow-s9/slideshow-impress.js/master/sample.md)
and [`impress2.js.text`](https://raw.github.com/slideshow-s9/slideshow-impress.js/master/sample2.md))
in Markdown in your working folder.

```
title: impress.js | the power of CSS3 transforms and transitions
author: Bartek Szopka


!SLIDE slide x=-1000 y=-1500

Aren't you just **bored** with all those slides-based presentations?


!SLIDE slide x=0 y=-1500

Don't you think that presentations given **in modern browsers**
shouldn't **copy the limits** of 'classic' slide decks?


!SLIDE slide x=1000 y=-1500

Would you like to **impress your audience**
with **stunning visualization** of your talk?


!SLIDE x=0 y=0 scale=4

then you should try  
impress.js<sup>*</sup>  
<sup>*</sup>no rhyme intended


!SLIDE x=850 y=3000 rotate=90 scale=5

It's a **presentation tool**  
inspired by the idea behind [prezi.com](http://prezi.com)  
and based on the **power of CSS3 transforms and transitions** in modern browsers.


!SLIDE x=3500 y=2100 rotate=180 scale=6

visualize your **big** thoughts


!SLIDE x=2825 y=2325 z=-3000 rotate=300 scale=1

and **tiny** ideas


!SLIDE x=3500 y=-850 rotate=270 scale=6

by **positioning**, **rotating** and **scaling** them on an infinite canvas


!SLIDE x=6700 y=-300 scale=6

the only **limit** is your **imagination**


!SLIDE x=6300 y=2000 rotate=20 scale=4

want to know more?
[use the source](http://github.com/impress/impress.js), Luke!
```

Showtime! Let's use the `-t/--template` switch to build the
sample slide show. Example:

    $ slideshow build impress.js.text -t impress.js

Open up the generated `impress.js.html` page in your browser. Voila. That's it.
