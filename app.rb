require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

get '/' do
  erb 'You can download this site from this <a href="https://github.com/art102/sinatra-bootstrap.git">repository</a>.'
end

get '/visit' do
	erb :visit
end

post '/visit' do

	@username = params[:username]
	@phone = params[:phone]
	@date_time = params[:date_time]
	@barber = params[:barber]
	@color = params[:color]

	hh = { :username => 'Введите имя',
				 :phone => 'Введите телефон',
				 :date_time => 'Введите дату и время'
			  }

	hh.each do |key, value|
		
		if params[key] == ''
			@error = hh[key]

			return erb :visit
		end	
	
	end	

	erb "OK, Username is #{@username}, #{@phone}, #{@date_time}, #{@barber}, #{@color}"

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

post '/contacts' do
	@user_contacts = params[:user_contacts]

	if @user_contacts == ''
		@error = 'Вы ничего не ввели'

		return erb :contacts
	end

	file = File.open('./public/contacts.txt','a')
	file.write("Users contacts: #{@user_contacts}\n")
	file.close

	erb :contacts

end
