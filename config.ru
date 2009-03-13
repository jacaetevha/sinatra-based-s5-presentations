require 'sinatra'
 
# include our Application code
require File.join(File.dirname(__FILE__), 'slideshow.rb')

# disable sinatra's auto-application starting
disable :run

# set our views directory
set :views, File.join(File.dirname(__FILE__), 'views')
 
# we're in dev mode
set :environment, :development
 
run Sinatra::Application
