RedcarpetYT: Markdown with YouTube Embedding
============================================================

RedcarpetYT is a Ruby library for Markdown processing with YouTube embedding based on [Redcarpet](https://github.com/vmg/redcarpet)

This library is written by people
---------------------------------

RedcarpetYT was written by [Scott Werwath](https://github.com/swerwath).

RedcarpetYT is an extension of Redcarpet, which was written by [Vicent Martí](https://github.com/vmg). It is maintained by
[Robin Dupret](https://github.com/robin850) and [Matt Rogers](https://github.com/mattr-).

Redcarpet would not be possible without the [Sundown](https://www.github.com/vmg/sundown)
library and its authors (Natacha Porté, Vicent Martí, and its many awesome contributors).

You can totally install it as a Gem
-----------------------------------

Redcarpet is readily available as a Ruby gem. It will build some native
extensions, but the parser is standalone and requires no installed libraries.
Starting with Redcarpet 3.0, the minimum required Ruby version is 1.9.2 (or Rubinius in 1.9 mode).

    $ [sudo] gem install redcarpet_yt

The RedcarpetYT source is available at GitHub:

    $ git clone git://github.com/swerwath/redcarpet_yt.git


And it's like simple to use
------------------------------------

The core of the Redcarpet library is the `Redcarpet::Markdown` class. Each
instance of the class is attached to a `Renderer` object; the Markdown class
performs parsing of a document and uses the attached renderer to generate
output.

The `Redcarpet::Markdown` object is encouraged to be instantiated once with the
required settings, and reused between parses.

~~~~~ ruby
# Initializes a Markdown parser
markdown = Redcarpet::Markdown.new(renderer, extensions = {})
~~~~~

Here, the `renderer` variable refers to a renderer object, inheriting
from `Redcarpet::Render::Base`. If the given object has not been
instantiated, the library will do it with default arguments.

Rendering with the `Markdown` object is done through `Markdown#render`.
Unlike in the RedCloth API, the text to render is passed as an argument
and not stored inside the `Markdown` instance, to encourage reusability.
Example:

~~~~~ ruby
markdown.render("This is *bongos*, indeed.")
# => "<p>This is <em>bongos</em>, indeed.</p>"
~~~~~

You can also specify a hash containing the Markdown extensions which the
parser will identify. The following extensions are accepted:

* `:no_intra_emphasis`: do not parse emphasis inside of words.
Strings such as `foo_bar_baz` will not generate `<em>` tags.

* `:tables`: parse tables, PHP-Markdown style.

* `:fenced_code_blocks`: parse fenced code blocks, PHP-Markdown
style. Blocks delimited with 3 or more `~` or backticks will be considered
as code, without the need to be indented. An optional language name may
be added at the end of the opening fence for the code block.

* `:autolink`: parse links even when they are not enclosed in `<>`
characters. Autolinks for the http, https and ftp protocols will be
automatically detected. Email addresses and http links without protocol,
but starting with `www` are also handled.

* `:disable_indented_code_blocks`: do not parse usual markdown
code blocks. Markdown converts text with four spaces at
the front of each line to code blocks. This option
prevents it from doing so. Recommended to use
with `fenced_code_blocks: true`.

* `:strikethrough`: parse strikethrough, PHP-Markdown style.
Two `~` characters mark the start of a strikethrough,
e.g. `this is ~~good~~ bad`.

* `:lax_spacing`: HTML blocks do not require to be surrounded by an
empty line as in the Markdown standard.

* `:space_after_headers`: A space is always required between the hash
at the beginning of a header and its name, e.g. `#this is my header`
would not be a valid header.

* `:superscript`: parse superscripts after the `^` character; contiguous superscripts
are nested together, and complex values can be enclosed in parenthesis, e.g.
`this is the 2^(nd) time`.

* `:underline`: parse underscored emphasis as underlines.
`This is _underlined_ but this is still *italic*`.

* `:highlight`: parse highlights.
`This is ==highlighted==`. It looks like this: `<mark>highlighted</mark>`

* `:quote`: parse quotes.
`This is a "quote"`. It looks like this: `<q>quote</q>`

* `:footnotes`: parse footnotes, PHP-Markdown style. A footnote works very much
like a reference-style link: it consists of a  marker next to the text (e.g.
`This is a sentence.[^1]`) and a footnote definition on its own line anywhere
within the document (e.g. `[^1]: This is a footnote.`).

Example:

~~~ruby
markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
 ~~~~~
 
So how do I embed YouTube videos?
-----------------------------------
First, make sure your `markdown` object uses the YouTube class:
~~~ruby
markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTMLwithYouTube, autolink: true, tables: true)
 ~~~~~
Then, you can embed YouTube videos in your Markdown with the same syntax as you do with images. The renderer is smart enough to recognize if you're linking to a video. For example,
~~~ruby
my_markdown_string = "![crazy alt text](https://www.youtube.com/watch?v=e79SuHotazs)"
 ~~~~~
 Then, just feed that Markdown into your renderer:
 ~~~ruby
html_string = markdown.render(my_markdown_string)
 ~~~~~
