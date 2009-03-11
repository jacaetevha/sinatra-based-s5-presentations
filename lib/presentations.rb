require 'sequel'

unless Object.const_defined? 'DB'
  DB = Sequel.mysql(:user=>'jrogers',:password=>'wnikam22',:host=>'localhost',:database=>'sinatra_presentation')
end

class Presentation < Sequel::Model(:presentations)
  has_many :slides
  
  def url
    Sinatra::Application.url_for_presentation(self)
  end
end

class Slide < Sequel::Model(:slides)
  has_many :points
  belongs_to :presentation
end

class Point < Sequel::Model(:points)
  belongs_to :slide
end