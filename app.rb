require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

get '/' do
  erb 'You can download this site from this <a href="https://github.com/art102/sinatra-bootstrap.git">repository</a>.'
end

def auth
	@name = params[:username]
	@pass = params[:password]

	if @name == 'admin' && @pass == 'secret'
	 erb :admin_page
	else
		@message = 'Acces denied!'
		erb :login_form
	end
end

