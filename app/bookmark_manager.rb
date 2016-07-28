ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require_relative 'data_mapper_setup'
require 'sinatra/flash'

class BookmarkManager < Sinatra::Base
  enable :sessions
  register Sinatra::Flash
  set :session_secret, 'Bookmark Secret'

  get '/links' do
    @links = Link.all
    erb(:'/links/index')
  end

  get '/links/new' do
    erb(:'links/new')
  end

  post '/links' do
    link = Link.create(:title => params[:title], :url => params[:url])
    params[:tags].split(/[\s,]+/).each do |tag|
      link.tags << Tag.first_or_create(:name => tag)
    end
    link.save
    redirect '/links'
  end

   get '/tags/:name' do
     tag = Tag.first(name: params[:name])
     @links = tag ? tag.links : []
     erb :'links/index'
   end

   get '/users' do
     @first_name = session[:first_name]
     @last_name = session[:last_name]
     @email = session[:email]
     erb :'users/signup'
   end

   post '/users' do
     session[:first_name] = params[:first_name]
     session[:last_name] = params[:last_name]
     session[:email] = params[:email]
     user = User.create(:first_name => params[:first_name], :last_name => params[:last_name], :email => params[:email], :password => params[:password], :password_confirmation => params[:password_confirmation])
     if user.id
       session[:user_id] = user.id
       redirect '/links'
     else
       flash[:invalid_passwords] = "passwords do not match"
       redirect '/users'
     end
   end


   helpers do
     def current_user
       @current_user ||= User.get(session[:user_id])
     end
   end


  # start the server if ruby file executed directly
  run! if app_file == $0
end
