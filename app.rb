 #encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, {adapter: "sqlite3", database: "barbershop.db"}
class Client < ActiveRecord::Base
	validates :name, presence: true, length: {minimum: 3}
	validates :phone, presence: true
	validates :datestamp, presence: true
	validates :color, presence: true
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
	 @c = Client.new
	 erb :visit
 end

 post '/visit' do

	 @c = Client.new params[:client]
	 if @c.save
		 erb "Спасибо, вы записались"
	 else
		 @error = @c.errors.full_messages.first
		 erb :visit
	 end
 end

 get '/contacts' do
	 erb :contacts
 end

 post '/contacts' do
	 @usermessage = params[:usermessage]

	 Contact.create :message => @usermessage

	 erb :contacts
 end

 get '/barber/:id' do
	 @barber = Barber.find(params[:id])
	 erb :barber
 end

 get '/bookings' do
	@clients = Client.order('created_at DESC')
	erb :bookings
 end
 