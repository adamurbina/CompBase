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

  get '/new' do
    @user = Helper.current_user(session)
    if @user
      @buildings = Building.all
      erb :'/comps/new_comp'
    else
      redirect '/'
    end
  end

  get '/comps/:id' do
    
  end

  get '/comps/:id/edit' do
    @comp = Comp.find_by(id: params[:id])
    if @comp.user == Helper.current_user(session)
      erb :'/comps/edit_comp'
    else
      redirect '/home'
    end
  end

  post '/new' do

    new_comp = Comp.new
    user = Helper.current_user(session)

    params[:comp].each do |attribute, value|
      value.empty? ? (redirect "/new") : (new_comp.send("#{attribute}=", value))
    end

    if params[:building_id]
      building = Building.find_by(id: params[:building_id])
    else
      building = Building.create(address: params[:building][:address], city_state: params[:building][:city_state])
    end

    new_comp.building = building
    new_comp.user = user
    new_comp.save

    redirect "/comps/#{new_comp.id}"

  end

end
