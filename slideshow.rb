require 'sinatra'
require 'lib/base'

# set :static, true
set :logging, true
set :app_file, __FILE__

configure(:development) do
  set :slides, 'lib/slides'
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
        buffer << haml(template, options.merge(:layout => false, :locals => {template.to_sym => member}))
        # buffer << haml(template, options.merge(:layout => false, template.to_sym => member))
      end.join("\n")
    else
      haml(template, options)
    end
  end
  
  def haml_escape(text)
    if text[0].chr == '.' || text[0].chr == '#'
      '\\' + text
    else
      text
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
  @slides = Slide.all.each do |slide|
    slide.title = haml(haml_escape(slide.title), :layout => false)
    slide.points = slide.points.collect do |point|
      haml(haml_escape(point), :layout => false)
    end
  end
  haml :slides
end

%w{framing opera outline pretty print s5-core slides}.each do |style|
  get "/ui/#{style}.css" do
    response['Content-Type'] = 'text/css; charset=utf-8'
    sass style.to_sym
  end
end
