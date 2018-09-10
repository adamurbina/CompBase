class UsersController < ApplicationController

  get '/' do
    if Helper.is_logged_in?(session)
      @user = Helper.current_user(session)
      redirect '/home'
    else
      erb :'/welcome'
    end
  end

  get '/login' do

    if Helper.is_logged_in?(session)
      redirect '/home'
    else
      erb :'/users/login'
    end
  end

  get '/signup' do
    erb :'/users/signup'
  end

  post '/signup' do

    params.each do |key, value|
      redirect '/signup' if value.empty?
    end

    user = User.create(username: params[:username], password: params[:password], email: params[:email])
    session[:user_id] = user.id
    redirect '/home'
  end

  get '/users/:id' do
    @user = User.find_by(id: params[:id])
    if @user.id == Helper.current_user(session).id
      erb :'/users/show'
    else
      redirect '/'
    end

  end

  post '/login' do
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/users/#{user.id}"
    else
      redirect '/'
    end
  end

end
