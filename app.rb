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
	@master = params[:master]
	@color = params[:color]

	#if @username == '' || @phone == '' || @date_time == ''
	#	@error = 'Вы что-то не ввели!'
	#	erb :visit
	if @username == ''
		@error = 'Вы не ввели имя'
		erb :visit
	elsif @phone == ''
		@error = 'Вы не ввели телефон'
		erb :visit
	elsif @date_time == ''
		@error = 'Вы не ввели дату'
		erb :visit
	else
		file = File.open('./public/users.txt','a')
		file.write("Name: #{@username}, Phone:#{@phone}, Date and time: #{@date_time}, Master: #{@master}, Color: #{@color}\n")
		file.close

		erb :visit

	end

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

	file = File.open('./public/contacts.txt','a')
	file.write("Users contacts: #{@user_contacts}\n")
	file.close

	erb :contacts

end