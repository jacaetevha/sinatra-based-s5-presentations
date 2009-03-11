require 'singleton'

class Array
  def extract_options!
    last.is_a?(::Hash) ? pop : {}
  end
end

class SlideStore
  include Singleton

  attr_reader :slides
  
  def initialize
    clear_all
  end
  
  def clear_all
    @slides = []
  end
  
  def load_slides(file)
    clear_all
    instance_eval do
      file += '.rb' unless file =~ /\.rb$/
      load file
    end
  end

end

class Slide
  @@main_title = 'Presentation'

  def self.all
    SlideStore.instance.slides
  end
  
  def self.main_title
    @@main_title
  end
  
  def self.main_title=(a_title)
    @@main_title = a_title
  end
  
  attr_accessor :title, :points, :handout_material

  def initialize(opts={})
    SlideStore.instance.slides << self
    self.title = opts[:title] || ''
    self.points = [opts[:points] || []].flatten
    self.handout_material = opts[:handout_material] || ''
  end

end
