require 'sinatra'
require 'lib/base'

# set :static, true
set :logging, true
set :app_file, __FILE__

configure(:development) do
  if ENV['sinbasp_engine'] == 'erb'
    Slide.engine = :erb 
    set :slides, 'lib/erb_slides'
  else
    set :slides, 'lib/slides'
  end
end

helpers do
  def presentation_title
    Slide.main_title
  end

  def base_url(scheme='http://')
    url = "#{scheme}#{Sinatra::Application.host}"
    url += ":#{Sinatra::Application.port}" unless Sinatra::Application.port.to_s == '80'
    url
  end

  def partial(template, *args)
    options = args.extract_options!
    options.merge!(:layout => false)
    if collection = options.delete(:collection) then
      collection.inject([]) do |buffer, member|
        puts "\n\n#{template.inspect}\n\n"
        puts "\n\n#{args.inspect}\n\n"
        puts "\n\n#{collection.inspect}\n\n"
        buffer << self.send(Slide.engine, template, options.merge(:layout => false, :locals => {template.to_sym => member}))
        # buffer << haml(template, options.merge(:layout => false, template.to_sym => member))
      end.join("\n")
    else
      self.send(Slide.engine, template, options)
    end
  end
  
end

def gist(id)
  "%script{:src => 'http://gist.github.com/#{id}.js', :type => 'text/javascript' }"
end

get '/' do
  begin
    SlideStore.instance.load_slides options.slides
  rescue
    Slide.new(:title => $!.message, :points => ['advance slide for stacktrace'])
    Slide.new(:title => 'stacktrace', :points => $@)
  end
  @slides = Slide.all
  self.send Slide.engine, :slides
end

%w{framing opera outline pretty print s5-core slides}.each do |style|
  get "/ui/#{style}.css" do
    response['Content-Type'] = 'text/css; charset=utf-8'
    sass style.to_sym
  end
end
