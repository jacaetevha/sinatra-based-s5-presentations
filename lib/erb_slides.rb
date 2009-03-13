Slide.main_title = "S5 meets Sinatra : Using ERb"

Slide.new(:title => '<h1>Sinatra-based S5 Presentations</h1>')

Slide.new(:title => 'One', :points => [
  "<b><%= 'point'.split('').join('.') %></b> is bolded",
  "<i><%= 'point'.split('').join('.') %></i> is italicized"
])

Slide.new(:title => 'Two', 
  :points => 'referencing instance variables is <%= @my_refs || "not working" %>', 
  :variables => {:my_refs => 'working'})