Slide.main_title = "Quick 'n' Clean REST via Sinatra"

Slide.new(:title => %q{
%h1
  Sinatra
  %h3
    Micro-Framework for the Web
})

Slide.new(:title => 'The Basics', :points => [
  'Sweet', 'Simple', '... and to the Point'
])

Slide.new(:title => 'Get outta my face', :points => [
  'Minimal layer over HTTP',  'Handles it', 'Gets out of your way'
])

Slide.new(:title => 'exploiting the simplicity of HTTP', :points => [
  'GET', 'POST', 'PUT', 'DELETE'
])

Slide.new(:title => 'exploiting the simplicity of HTTP', :points => [
  %q{
%p
  %strong
    get
  '/items' do
  %br
  \...
  %br
  end
%p
  %strong
    post
  '/items' do
  %br
  \...
  %br
  end
%p
  %strong
    put
  '/items/:id' do
  %br
  \...
  %br
  end
%p
  %strong
    delete
  '/items/:id' do
  %br
  \...
  %br
  end
}
])

Slide.new(:title => 'Simple Routing', :points => gist(77286))

Slide.new(:title => 'Parameterized Routing', :points => gist(77291))

Slide.new(:title => 'Parameterized Routing', :points => gist(77294))

Slide.new(:title => 'Programmatic Routing', :points => gist(77268))

Slide.new(:title => 'Resource Formats', :points => gist(77299))

Slide.new(:title => 'So much for GET, what about the others?', :points => [
  'POST, PUT, DELETE', 'Sinatra\'s got \'em, so why not use \'em',
  'Sinatra will read the headers or look for a special "_method" parameter',
  'Purists say "It MUST be in the HEADER"',
  'Pragamatists say "Who cares? Do what\'s easiest and most common"'
])

Slide.new(:title => "Getting Classy", :points => ["sudo get install sinatra",
  "(ruby|jruby) -rubygems app.rb", "Sinatra will look for a Rack compatible web-server and use it",
  "go to http://localhost:4567"
])

Slide.new(:title => "Uh Oh! No No! -- Live Demo")