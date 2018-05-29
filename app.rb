require 'sinatra'
require 'sinatra/activerecord' 
require 'rake'
require 'pg'
require 'faker'

require_relative './models/User'
require_relative './models/Post'
require_relative './models/Tag'


# set :database, {adapter: 'postgresql', database: 'crime_blog'}

enable :sessions

#welcome page
get '/' do 
    erb :index
end
# end

#homepage showing all posts
get '/home' do 
    @posts = Post.all
    erb :home
end

post '/home' do
    @posts = Post.all
    erb :home
end

#show a user's profile and posts
get '/users/show' do
    @user = User.find(session[:id])
    erb :'/users/show'
end

#signup page to create new user
get '/signup' do
    erb :'/users/signup'
end

#create new user
post '/user/new' do 
    @newuser = User.create(first_name: params[:first_name], last_name: params[:last_name], email: params[:email], password: params[:password], birthday: params[:birthday])
    session[:id] = @newuser.id
    redirect '/home'
end

#login page
get '/login' do
    erb :'users/login'
end

#process login request 
post '/login' do 
    @user = User.find_by(email: params[:email], password: params[:password])
    if @user != nil
        session[:id] = @user.id
        redirect '/users/show'
    else   
        redirect '/signup'
    end 
end

#logout process
get '/logout' do
    session.clear
    redirect '/'
end


get '/list' do
    @users = User.all
    erb :'/users/list'
end

#user can delete their account
get '/delete' do 
    erb :deleteprofile, :layout => :layout
end

delete '/profile/delete' do 
    @user = User.find(session[:id])
    @user.destroy
    session.clear
    redirect '/'
end

    # User.destroy(session[:id])
    # session.clear


#create new post
get '/posts/new' do
     erb :'posts/new'
end


post '/posts/save' do
    @user = User.find(session[:id])
    @post = Post.create(title: params[:title], content: params[:content], user_id: session[:id])
    redirect '/myposts'
	
    end


#show a user's posts
get '/myposts' do
    @user = User.find(session[:id])
    p @user
    @posts = @user.posts     
    p @posts
    erb :'/users/show'
end

post '/myposts' do
    @user = User.find(session[:id])
    @posts = @user.posts     
    erb :'/users/show'
end

get '/edit' do
    @user_avail = User.find(session[:id])
    erb :edit
end

helpers do
    def logged_in?
      !!session[:user_id]
    end

end