# encoding: utf-8
Gem::Specification.new do |s|
  s.name = 'redcarpet_yt'
  s.version = '0.1.0'
  s.summary = "Markdown that smells nice, now with YouTube embedding"
  s.description = 'A fast, safe and extensible Markdown to (X)HTML parser, with YouTube embedding, based on Redcarpet'
  s.date = '2016-03-31'
  s.email = 'swerwath@berkeley.edu'
  s.homepage = 'http://github.com/swerwath/redcarpet_yt'
  s.authors = ["Natacha Porté", "Vicent Martí", "Scott Werwath"]
  s.license = 'MIT'
  s.required_ruby_version = '>= 1.9.2'
  # = MANIFEST =
  s.files = %w[
    COPYING
    Gemfile
    README.md
    Rakefile
    bin/redcarpet
    ext/redcarpet/autolink.c
    ext/redcarpet/autolink.h
    ext/redcarpet/buffer.c
    ext/redcarpet/buffer.h
    ext/redcarpet/extconf.rb
    ext/redcarpet/houdini.h
    ext/redcarpet/houdini_href_e.c
    ext/redcarpet/houdini_html_e.c
    ext/redcarpet/html.c
    ext/redcarpet/html.h
    ext/redcarpet/html_blocks.h
    ext/redcarpet/html_smartypants.c
    ext/redcarpet/markdown.c
    ext/redcarpet/markdown.h
    ext/redcarpet/rc_markdown.c
    ext/redcarpet/rc_render.c
    ext/redcarpet/redcarpet.h
    ext/redcarpet/stack.c
    ext/redcarpet/stack.h
    lib/redcarpet_yt.rb
    lib/redcarpet/cli.rb
    lib/redcarpet/compat.rb
    lib/redcarpet/render_man.rb
    lib/redcarpet/render_strip.rb
    redcarpet_yt.gemspec
    test/benchmark.rb
    test/custom_render_test.rb
    test/fixtures/benchmark.md
    test/html5_test.rb
    test/html_render_test.rb
    test/html_toc_render_test.rb
    test/markdown_test.rb
    test/pathological_inputs_test.rb
    test/redcarpet_bin_test.rb
    test/redcarpet_compat_test.rb
    test/safe_render_test.rb
    test/smarty_html_test.rb
    test/smarty_pants_test.rb
    test/stripdown_render_test.rb
    test/test_helper.rb
  ]
  # = MANIFEST =
  s.test_files = s.files.grep(%r{^test/})
  s.extra_rdoc_files = ["COPYING"]
  s.extensions = ["ext/redcarpet/extconf.rb"]
  s.executables = ["redcarpet"]
  s.require_paths = ["lib"]

  s.add_development_dependency "rake", "~> 10.5"
  s.add_development_dependency "rake-compiler", "~> 0.9.5"
  s.add_development_dependency "test-unit", "~> 3.1.3"
end
