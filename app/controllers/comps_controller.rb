class CompsController < ApplicationController
  get '/home' do
    if Helper.is_logged_in?(session)
      @comps = Comp.all
      @user = Helper.current_user(session)
      erb :'/comps/home'
    else
      redirect '/'
    end
  end

  get '/comps/:id/edit' do
    
  end

end
