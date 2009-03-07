require 'sinatra'
require 'lib/slides'
require 'lib/extensions'

helpers do
  def slide_show_title
    "Quick 'n' Dirty REST via Sinatra"
  end

  def partial(template, *args)
    options = args.extract_options!
    options.merge!(:layout => false)
    if collection = options.delete(:collection) then
      collection.inject([]) do |buffer, member|
        buffer << haml(template, options.merge(:layout => false, :locals => {template.to_sym => member}))
      end.join("\n")
    else
      haml(template, options)
    end
  end  
end

get '/' do
  @slides = Slide.all
  haml :slides
end

%w{framing opera outline pretty print s5-core slides}.each do |style|
  get "/ui/#{style}.css" do
    header 'Content-Type' => 'text/css; charset=utf-8'
    sass style.to_sym
  end
end