require 'sinatra'
require 'sinatra/reloader'
require "sinatra/activerecord"
require 'pry'

require_relative 'models/contact'
also_reload 'models/contact'





get '/' do
  items_per_page = 2
  @page_number = 1

  @contacts = Contact.all.limit(items_per_page)
  erb :index
end

get '/:page_number' do

  items_per_page = 2
  offset = 0
  if params[:page_number]
    offset = items_per_page * params[:page_number].to_i
    @page_number = params[:page_number].to_i
  end

  @contacts = Contact.all.limit(items_per_page).offset(offset)
  erb :index
end

get '/contacts/:id' do
  @contact = Contact.find(params[:id])

  erb :show
end
