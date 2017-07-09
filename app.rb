require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

get '/' do
  erb 'You can download this site from this <a href="https://github.com/art102/sinatra-bootstrap.git">repository</a>.'
end

get '/visit' do
	erb :visit
end

get '/about' do
	erb :about
end

get '/mission' do
	erb :mission
end

get '/contacts' do
	erb :contacts
end