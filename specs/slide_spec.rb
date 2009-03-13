require 'rubygems'
require 'lib/base'

context "Slides should be renderable by the HAML engine" do
  it "should work with titles" do
    slide = Slide.new(:title => "%b This should be bold text")
    slide.title.should == "<b>This should be bold text</b>\n"
  end

  it "should not translate plain text titles" do
    slide = Slide.new(:title => "This is plain text")
    slide.title.should == "This is plain text\n"
  end
  
  it "should HAMLize a single point on the slide" do
    slide = Slide.new(:points => "a single\n%i\n  = 'point'.split('').join('.')")
    slide.points.should == ["a single\n<i>\n  p.o.i.n.t\n</i>\n"]
  end

  it "should HAMLize multiple points on the slide" do
    slide = Slide.new(:points => ["a single\n%i\n  = 'point'.split('').join('.')",
      "%p a para",
      "%a{:href=>'http://www.google.com'}\n  Google"])

    slide.points.should == ["a single\n<i>\n  p.o.i.n.t\n</i>\n", 
      "<p>a para</p>\n", 
      "<a href='http://www.google.com'>\n  Google\n</a>\n"]
  end
  
  it "should handle HAML text that starts with a class or id selector" do
    slide = Slide.new(:points => ".css_class a single\n%i\n  = 'point'.split('').join('.')")
    slide.points.should == ["<div class='css_class'>a single</div>\n<i>\n  p.o.i.n.t\n</i>\n"]
  end
  
  it "should allow the setting of instance variables" do
    slide = Slide.new(:title => 'Two', 
      :points => 'referencing instance variables is <%= @my_refs || "not working" %>', 
      :variables => {:my_refs => 'working'})

    "working".should == slide.instance_variable_get( "@my_refs" )
  end
end

context "Slides should be renderable by the ERb engine" do
  before :all do
    Slide.engine = :erb
    Slide.engine.should == :erb
  end

  it "should work with titles" do
    slide = Slide.new(:title => "<b>This should be bold text</b>")
    slide.title.should == "<b>This should be bold text</b>"
  end

  it "should not translate plain text titles" do
    slide = Slide.new(:title => "This is plain text")
    slide.title.should == "This is plain text"
  end
  
  it "should ERb-ify a single point on the slide" do
    slide = Slide.new(:points => %q{a single
  <i><%= "point".split('').join(".") %></i>
})
    slide.points.should == ["a single\n  <i>p.o.i.n.t</i>\n"]
  end

  it "should ERb-ify multiple points on the slide" do
    number = 42
    slide = Slide.new(:points => ['a single<i><%= "point".split("").join(".") %></i>',
                                  "<p>a para</p>",
                                  "<a href='http://www.google.com?q=is+<%= @num %>+the+answer+to+life'>Google</a>"],
                      :variables => {:num => number})

    slide.points.should == ["a single<i>p.o.i.n.t</i>", 
                            "<p>a para</p>",
                            "<a href='http://www.google.com?q=is+42+the+answer+to+life'>Google</a>"]
  end
end
