Gem::Specification.new do |s|
  s.specification_version = 2 if s.respond_to? :specification_version=
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=

  s.name = 'sinbasp'
  s.version = '0.1.2'
  s.date = '2009-03-13'

  s.description = "Classy S5 Presentations"
  s.summary     = "A Simple Standards-Based Slide Show System served up by Sinatra"

  s.authors = ["Jason Rogers"]

  # = MANIFEST =
  s.files = %w[
    CHANGES
    LICENSE
    README.rdoc
    VERSION
    sinbasp.rb
    lib/base.rb
    lib/erb_slides.rb
    lib/slides.rb
    public/blank.gif
    public/bodybg.gif
    public/homover.gif
    public/slides.css
    public/slides.js
    specs/slide_spec.rb
    views/framing.sass
    views/layout.erb
    views/layout.haml
    views/opera.sass
    views/outline.sass
    views/pretty.sass
    views/print.sass
    views/s5-core.sass
    views/slide.erb
    views/slide.haml
    views/slides.erb
    views/slides.haml
  ]
  # = MANIFEST =

  s.test_files = s.files.select {|path| path =~ /^spec\/.*_spec.rb/}

  s.extra_rdoc_files = %w[README.rdoc LICENSE CHANGES VERSION]
  s.add_dependency 'sinatra', '>= 0.9.0'

  s.has_rdoc = true
  s.homepage = "http://wiki.github.com/jacaetevha/sinatra-based-s5-presentations"
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Sinatra Based S5 Presentations (SinBaSP)", "--main", "README.rdoc"]
  s.require_paths = %w[. lib]
  s.rubygems_version = '1.1.1'
end
