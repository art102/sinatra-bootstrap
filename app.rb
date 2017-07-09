require 'rubygems'
require 'sinatra'


get '/' do
  erb 'Can you handle a <a href="/secure/place">secret</a>?'
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

