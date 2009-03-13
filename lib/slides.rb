Slide.main_title = "S5 meets Sinatra"

Slide.new(:title => %q{
%h1
  Sinatra-based S5 Presentations
})

Slide.new(:title => 'Points', :points => "Points can be plain text")

Slide.new(:title => 'Points can be a list of plain text', :points => [
  'Sweet', 'Simple', '\\... and to the Point'
])

Slide.new(:title => 'Points can be HAML', :points => %q{
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
})

Slide.new(:title => "%i\n  Titles can be HAML", :points => "The title of this screen should be in\n%i\n  italics")

Slide.new(:title => 'Gists are supported', :points => gist(75985))

Slide.new(:title => "more information", :points => [
  "%a{:href=>'http://www.sinatrarb.com/'}\n  Sinatra",
  "%a{:href=>'http://meyerweb.com/eric/tools/s5/'}\n  Eric Meyer's S5",
])