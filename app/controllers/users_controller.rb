class UsersController < ApplicationController

  get '/' do
    if Helper.is_logged_in?(session)
      @user = Helper.current_user(session)
      redirect '/home'
    else
      erb :'/welcome'
    end
  end

  get '/home' do
    if Helper.is_logged_in?(session)
      @comps = Comp.all
      @user = Helper.current_user(session)
      redirect "users/#{@user.id}"
    else
      redirect '/'
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
      flash[:message] = "Error creating account. Please try again."
      redirect '/signup' if value.empty?
    end

    if User.find_by(username: params[:username]) || User.find_by(email: params[:email])
      flash[:message] = "Username or email already exists!"
      redirect '/signup'
    end

    user = User.create(username: params[:username], password: params[:password], email: params[:email])
    session[:user_id] = user.id
    redirect '/home'
  end

  get '/users/:id' do
    @user = User.find_by(id: params[:id])
    if @user.id == Helper.current_user(session).id
      erb :'/users/user_comps'
    else
      redirect '/'
    end

  end

  post '/login' do
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:message] = "Welcome back!"
      redirect "/users/#{user.id}"
    else
      flash[:message] = "Log in failed!"
      redirect '/'
    end
  end

  post '/logout' do
    session.clear
    flash[:message] = "Goodbye. Come back soon!"
    erb :'/welcome'
  end

end
