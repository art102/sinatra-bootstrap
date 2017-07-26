require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'

def is_barber_exists? db, name
	db.execute('select * from Barbers where name=?', [name]).length > 0
end

def seed_db db, barbers

	barbers.each do |barber|
		if !is_barber_exists? db, barber
			db.execute 'insert into Barbers (name) values (?)', [barber]
		end
	end

end

def get_db
	db = SQLite3::Database.new 'barbershop.db'
	db.results_as_hash = true
	return db
end

configure do
	db = get_db
	db.execute 'CREATE TABLE IF NOT EXISTS 
		"Users" 
		(
				"id" INTEGER PRIMARY KEY AUTOINCREMENT, 
				"username" TEXT, 
				"phone" TEXT, 
				"datestamp" TEXT, 
				"barber" TEXT, 
				"color" TEXT
		)'

		db.execute 'CREATE TABLE IF NOT EXISTS 
			"Barbers" 
			(
					"id" INTEGER PRIMARY KEY AUTOINCREMENT, 
					"name" TEXT 
			)'

		seed_db db, ['Jessie Pinkman', 'Walter White', 'Gus Fring', 'Mike Ehrmantraut']
end

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

	db = get_db
	db.execute 'insert into Users (username, phone, datestamp, barber, color) values (?, ?, ?, ?, ?)', [@username, @phone, @date_time, @barber, @color]

	erb "OK, Username is #{@username}, #{@phone}, #{@date_time}, #{@barber}, #{@color}"

end

def get_db
	return SQLite3::Database.new 'barbershop.db'
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

get '/showusers' do
	db = SQLite3::Database.new 'barbershop.db'
	db.results_as_hash = true

	@results = db.execute 'select * from Users order by id desc'

	erb :showusers
end
