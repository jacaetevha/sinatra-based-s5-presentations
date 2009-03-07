class Slide
  @@all_slides = []
  
  def self.all
    @@all_slides
  end
  
  attr_accessor :title, :points, :handout_material

  def initialize(opts={})
    @@all_slides << self
    self.title = opts[:title] || ''
    self.points = opts[:points] || []
    self.handout_material = opts[:handout_material] || ''
  end
end

Slide.new(:title => 'Sinatra : Web Micro-Framework')
Slide.new(:title => 'Words', :points => %w{first second third}, :handout_material => 'This is the first slide')
Slide.new(:title => 'Letters', :points => %w{A B C}, :handout_material => 'This is the second slide')
Slide.new(:title => 'Numbers', :points => %w{1 2 3 4 5 6}, :handout_material => 'This is the third slide')
Slide.new(:title => 'Primary Colors', :points => %w{Red Blue Yellow}, :handout_material => 'This is the fourth slide')
Slide.new(:title => 'Secondary Colors', :points => %w{Green Purple}, :handout_material => 'This is the fifth slide')