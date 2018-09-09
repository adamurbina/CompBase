class UsersController < ApplicationController

  get '/' do
    if Helper.is_logged_in?(session)
      @user = Helper.current_user(session)
      redirect '/comps/home'
    else
      erb :'/welcome'
    end
  end

  get '/login' do

    if Helper.is_logged_in?(session)
      redirect '/comps/comps'
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
    redirect '/comps'
  end



end
