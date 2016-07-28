ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require_relative 'data_mapper_setup'
require 'sinatra/flash'

class BookmarkManager < Sinatra::Base
  use Rack::MethodOverride
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

   get '/users/new' do
     @user = User.new
     erb :'users/new'
   end

   post '/users' do
     @user = User.new(:first_name => params[:first_name], :last_name => params[:last_name], :email => params[:email], :password => params[:password], :password_confirmation => params[:password_confirmation])
     if @user.save
       session[:user_id] = @user.id
       redirect '/links'
     else
       flash.now[:errors] = @user.errors.full_messages
       erb :'users/new'
     end
   end

   get '/sessions/new' do
     erb :'/sessions/new'
   end

   post '/sessions' do
     user = User.authenticate(params[:email], params[:password])
     if user
       session[:user_id] = user.id
       redirect '/links'
     else
       flash.now[:errors] = ['The email or password is incorrect']
       erb :'/sessions/new'
     end
   end

    delete '/sessions' do
       session.clear
       flash.keep[:notice] = 'Bye'
       redirect '/links'
     end




   helpers do
     def current_user
       @current_user ||= User.get(session[:user_id])
     end
   end


  # start the server if ruby file executed directly
  run! if app_file == $0
end
