 #encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, {adapter: "sqlite3", database: "barbershop.db"}
class Client < ActiveRecord::Base
end

class Barber < ActiveRecord::Base
end
class Contact < ActiveRecord::Base
end

before do
	@barbers = Barber.all
	@clients = Client.all
	@contacts = Contact.all
end

get '/' do
	erb :index
end

 get '/visit' do
	 erb :visit
 end

 post '/visit' do
	 @username = params[:username]
	 @phone = params[:phone]
	 @datestamp = params[:datetime]
	 @barber = params[:barber]
	 @color = params[:colorpicker]

	 Client.create :name => @username, :phone => @phone, :datestamp => @datestamp, :barber => @barber, :color => @color

	 erb :visit
 end

 get '/contacts' do
	 erb :contacts
 end

 post '/contacts' do
	 @usermessage = params[:usermessage]

	 Contact.create :message => @usermessage

	 erb :contacts
 end

