require 'redcarpet.so'
require 'redcarpet/compat'

module Redcarpet
  VERSION = '3.3.4'

  class Markdown
    attr_reader :renderer
  end

  module Render
     # Custom renderer to let our markdown include embedded Youtube videos
     class HTMLwithYouTube < Redcarpet::Render::HTML
         def image(link, title, content)
             # Check if we have a YouTube video
             if link.match /((http(s)?:\/\/)?)(www\.)?((youtube\.com\/)|(youtu.be\/))[\S]+/
                 id = get_youtube_video_id(link)
                 '</p>
                 <div position="relative" padding-bottom="56.25%" padding-top="25px" height="0">
                    <iframe position="absolute" top="0" bottom="0" width="100%" height="320tu" src="//www.youtube.com/embed/'+id+'" frameborder="0" allowfullscreen></iframe>
                 </div>
                 <p>'
             else
                 '<img src="'+link+'" title="'+title+'" alt="'+content+'">'
             end
         end

         def get_youtube_video_id (url)
             regExp = /^.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/
             match = url.match(regExp)
             return match[2]
         end
     end

    # XHTML Renderer
    class XHTML < HTML
      def initialize(extensions = {})
        super(extensions.merge(xhtml: true))
      end
    end

    # HTML + SmartyPants renderer
    class SmartyHTML < HTML
      include SmartyPants
    end

    # A renderer object you can use to deal with users' input. It
    # enables +escape_html+ and +safe_links_only+ by default.
    #
    # The +block_code+ callback is also overriden not to include
    # the lang's class as the user can basically specify anything
    # with the vanilla one.
    class Safe < HTML
      def initialize(extensions = {})
        super({
          escape_html: true,
          safe_links_only: true
        }.merge(extensions))
      end

      def block_code(code, lang)
        "<pre>" \
          "<code>#{html_escape(code)}</code>" \
        "</pre>"
      end

      private

      # TODO: This is far from ideal to have such method as we
      # are duplicating existing code from Houdini. This method
      # should be defined at the C level.
      def html_escape(string)
        string.gsub(/['&\"<>\/]/, {
          '&' => '&amp;',
          '<' => '&lt;',
          '>' => '&gt;',
          '"' => '&quot;',
          "'" => '&#x27;',
          "/" => '&#x2F;',
        })
      end
    end

    # SmartyPants Mixin module
    #
    # Implements SmartyPants.postprocess, which
    # performs smartypants replacements on the HTML file,
    # once it has been fully rendered.
    #
    # To add SmartyPants postprocessing to your custom
    # renderers, just mixin the module `include SmartyPants`
    #
    # You can also use this as a standalone SmartyPants
    # implementation.
    #
    # Example:
    #
    #   # Mixin
    #   class CoolRenderer < HTML
    #     include SmartyPants
    #     # more code here
    #   end
    #
    #   # Standalone
    #   Redcarpet::Render::SmartyPants.render("you're")
    #
    module SmartyPants
      extend self
      def self.render(text)
        postprocess text
      end
    end
  end
end
