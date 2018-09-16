class CompsController < ApplicationController

  get '/all' do
    if Helper.is_logged_in?(session)
      @user = Helper.current_user(session)
      @comps = Comp.all
      erb :'/comps/all_comps'
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
    if Helper.is_logged_in?(session)
      @comp = Comp.find_by(id: params[:id])
      @user = Helper.current_user(session)
      erb :'/comps/show_comp'
    else
      redirect '/'
    end
  end

  get '/comps/:id/edit' do
    @comp = Comp.find_by(id: params[:id])
    if @comp.user == Helper.current_user(session)
      @buildings = Building.all
      @user = Helper.current_user(session)
      erb :'/comps/edit_comp'
    else
      redirect '/home'
    end
  end

  get '/comps/:id/delete' do
    @comp = Comp.find_by(id: params[:id])
    if @comp.user == Helper.current_user(session)
      erb :'/comps/delete_comp'
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
    flash[:message] = "New Comp Created!"

    redirect "/comps/#{new_comp.id}"

  end

  post '/comps/:id/edit' do
    @comp = Comp.find_by(id: params[:id])

    params[:comp].each do |attribute, value|
      value.empty? ? (redirect "/comps/#{@comp.id}/edit") : (@comp.send("#{attribute}=", value))
    end

    if params[:building_id]
      building = Building.find_by(id: params[:building_id])
    else
      building = Building.create(address: params[:building][:address], city_state: params[:building][:city_state])
    end

    @comp.building = building
    @comp.save

    redirect "/comps/#{@comp.id}"

  end

  post '/comps/:id/delete' do
    @comp = Comp.find_by(id: params[:id])
    @comp.delete
    @user = Helper.current_user(session)
    flash[:message] = "Comp deleted."
    redirect "/users/#{@user.id}"

  end

end
