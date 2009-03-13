require 'singleton'
require 'sinatra/base'

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
  include Sinatra::Templates
  
  @@main_title = 'Presentation'
  @@engine = :haml

  def self.all
    SlideStore.instance.slides
  end

  def self.engine
    @@engine
  end
  
  def self.engine=(symbol)
    @@engine = symbol
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
    if opts[:variables]
      opts[:variables].each_pair do |key, value|
        instance_variable_set "@#{key}", value
      end
    end
    
    self.title = rendered(opts[:title])
    self.points = rendered([opts[:points]].flatten)
    self.handout_material = rendered(opts[:handout_material])
  end
  
  private
    def rendered(text)
      return '' if text.nil?
      if text.kind_of? Array
        text.collect { |e| rendered e }
      else
        if text.kind_of?(Symbol)
          self.send(@@engine, text)
        else
          self.send(@@engine, text, :layout => false)
        end
      end
    end
end
