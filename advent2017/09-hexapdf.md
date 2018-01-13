
_A Versatile Portable Document Format (PDF) Creation and Manipulation Library and Command Line Tool_


# hexapdf library and command line tool - Read and Write PDF Documents; Start from Zero or Merge, Extract, Optimize and Much More  


github: [gettalong/hexapdf](https://github.com/gettalong/hexapdf),
rubygems: [hexapdf](https://rubygems.org/gems/hexapdf),
rdoc: [hexapdf](http://rubydoc.info/gems/hexapdf)


Written by [Thomas Leitner](https://rubygems.org/profiles/gettalong)  {% avatar gettalong %}



HexaPDF is a pure Ruby library with an accompanying application for working with PDF files.
In short, it allows

* **creating** new PDF files,
* **manipulating** existing PDF files,
* **merging** multiple PDF files into one,
* **extracting** meta information, text, images and files from PDF files,
* **securing** PDF files by encrypting them and
* **optimizing** PDF files for smaller file size or other criteria.

HexaPDF was designed with ease of use and performance in mind. It uses lazy loading and lazy computing when possible and tries to produce small PDF files by default.

If you are concerned regarding the performance, have a look at the following gists which show that HexaPDF performs quite well:

* [Raw text output performance](https://gist.github.com/gettalong/0d7c576064725774299cdf4d1a51d2b9)
* [Advanced text output (i.e. line wrapping) performance](https://gist.github.com/gettalong/8afae547ac3e50e9b8ce6c521a2a0eea)
* [HexaPDF CLI performance](https://gist.github.com/gettalong/8955ff5403fe7abb7bee)


## Examples


### Command Line  


The [manual page](https://hexapdf.gettalong.org/documentation/hexapdf.1.html) of the `hexapdf` command explains all functionality in detail. It basically strives to be a universal PDF manipulation tool.

* One common task is to **merge multiple PDFs into one**: `hexapdf merge input1.pdf input2.pdf input3.pdf output.pdf`.

  This takes `input1.pdf` and merges the other PDFs into it. So any information, for example an outline, present in `input1.pdf` will be in the output file. If this is not wanted, use `-e` (start with empty PDF file) directly before the first input file.

* Another common problem is the **optimization of PDFs**. Many applications tend to create huge PDFs that waste a lot of space. The `hexapdf optimize input.pdf output.pdf` command losslessly optimizes the `input.pdf` in terms of space usage and saves the new file as `output.pdf`.

  The important thing to remember here is that this transformation is done **losslessly** because some (online) tools boast with huge compression ratios but destroy information while optimizing, e.g. by down-sampling images.

  As for the performance of HexaPDF: It is actually quite good in terms of runtime and space savings, see [HexaPDF Performance Comparison](https://gist.github.com/gettalong/8955ff5403fe7abb7bee) for a comparison to other command line tools.

* If you need to perform a certain operation on many PDFs, the `hexapdf` command allows you to work in **batch mode**. The following example optimize three files and saving them with a filename prefix of `done-`:

  `hexapdf batch 'optimize --object-streams delete {} done-{}' input1.pdf input2.pdf input3.pdf`

  The first argument to `batch` is the command that should be executed, i.e. everything you would normally use but without the `hexapdf` command name. The input file can be represented as `{}`. All other arguments are the input file on which the batched command should be performed.

The `hexapdf` command provides many other functionalities, like decrypting or encrypting a file, extracting images or files from a PDF file, inspecting a PDF file and more.


### Ruby Code

Apart from providing the command line tool as one show-case application,
the HexaPDF library can be used for all things PDFs (except for rendering). The [examples section](https://hexapdf.gettalong.org/examples/index.html) on the HexaPDF homepage shows some of the things you can do.

One person on Reddit needed to stitch individual pages together into a single file. The [HexaPDF answer](https://www.reddit.com/r/pdf/comments/72wnkm/is_it_possible_to_stitch_hundreds_of_pages_into_a/) looks like this:

``` ruby
#!/usr/bin/env ruby
#
# Usage: stitch.rb column_count source.pdf dest.pdf
#
# Arranges the pages from source.pdf in a pattern where each +column_count+ pages
# are arranged from left to right. It is assumed that all pages are of the same
# size.
#
require 'hexapdf'

columns = ARGV[0].to_i
source_path, dest_path = *ARGV[1, 2]

source = HexaPDF::Document.open(source_path)
dest = HexaPDF::Document.new

rows = (source.pages.count / columns.to_f).ceil
page_width = source.pages[0].box.width
page_height = source.pages[0].box.height

puts "Source pages: #{source.pages.count} pages, #{page_width}pt x #{page_height}pt"
puts "Dest layout: #{columns} columns, #{rows} rows"

canvas = dest.pages.add([0, 0, page_width * columns, page_height * rows]).canvas
row = 1
column = 0
source.pages.each do |page|
  form = dest.import(page.to_form_xobject)
  canvas.xobject(form, at: [column * page_width, page_height * rows - row * page_height])
  column += 1
  if column == columns
    row += 1
    column = 0
  end
end
dest.write(dest_path)
```

And another one wanted to convert a huge text file into a single page PDF without too much whitespace. [Solved with HexaPDF](https://www.reddit.com/r/pdf/comments/6y5v0d/massive_txt_file_to_pdf_with_no_page_breaks_or/) like this (note that the code in the link only worked with an older version of HexaPDF, the code below works with HexaPDF 0.6.0):

``` ruby
require 'hexapdf'
require 'hexapdf/layout/text_layouter'

# read the file given as first command line argument
text = File.read(ARGV[0])

# create a new PDF document
doc = HexaPDF::Document.new

# create a text box, calculate the height and width
box = HexaPDF::Layout::TextLayouter.create(text, width: 1_000_000,
                                           font: doc.fonts.add("Courier"))
rest, = box.fit
width = box.lines.map(&:width).max
height = box.actual_height
raise "error" unless rest.empty?

# use the width and height for a new page with this dimensions and get the painting canvas
canvas = doc.pages.add([0, 0, width, height]).canvas

# draw the text box on the canvas
box.draw(canvas, 0, height)

# write the resulting PDF
doc.write('output.pdf')
```

Yet another redditer wanted to remove the top 3cm of each page, the [HexaPDF solution](https://www.reddit.com/r/pdf/comments/6q63mo/remove_top_3cm_from_a_pdf/) is this:

``` ruby
require 'hexapdf'

top_margin = 30 / 25.4 * 72
input = HexaPDF::Document.open(ARGV[0])
input.pages.each do |page|
  media_box = page.box.value.dup
  media_box[3] -= top_margin
  page[:MediaBox] = media_box
end
input.write(ARGV[1])
```

Sometimes one needs to create a PDF file from multiple JPEG images, one image per page, and wants to put them centered and scaled on the pages, with some space around. Here is the code to do that (note that placing images centered and scaled in a certain box will get much easier in the near future):

``` ruby
require 'hexapdf'

doc = HexaPDF::Document.new

ARGV.each do |image_file|
  image = doc.images.add(image_file)
  iw = image.info.width.to_f
  ih = image.info.height.to_f
  page = doc.pages.add(:A4, orientation: (ih > iw ? :portrait : :landscape))
  pw = page.box(:media).width.to_f - 72
  ph = page.box(:media).height.to_f - 72
  rw, rh = pw / iw, ph / ih
  ratio = [rw, rh].min
  iw, ih = iw * ratio, ih * ratio
  x, y = (pw - iw) / 2, (ph - ih) / 2
  page.canvas.image(image, at: [x + 36, y + 36], width: iw, height: ih)
end

doc.write('images.pdf')
```

## Conclusio

If you need to work with PDFs in Ruby, HexaPDF is probably the way to go!
