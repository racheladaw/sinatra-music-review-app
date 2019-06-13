class UsersController < ApplicationController

  get '/users' do
    @users = User.all
    erb :'/users/index'
  end

  get '/users/new' do
    erb :'/users/new'
  end

  post '/users' do
    #binding.pry
    u = User.new
    if !params[:username].empty?
      User.all.each do |user|
        if user.username == params[:username]
          redirect '/users/new'
        end
      end
      u.username = params[:username]
      u.password = params[:password]
      if u.save
        redirect '/login'
      end
    else
      redirect '/users/new'
    end
  end

  get '/users/:id' do
    @user = User.find(params[:id])
    erb :'/users/show'
  end

  get '/login' do
    #binding.pry
    if !logged_in?(session)
      erb :'/users/login'
    else
      redirect "/users/#{current_user(session).id}"
    end
  end

  post '/login' do
    #binding.pry
    u = User.find_by(username: params[:username])
    if u && u.authenticate(params[:password])
      session[:user_id] = u.id
      redirect "/users/#{u.id}"
    else
      redirect '/login'
    end
  end

  get '/logout' do
    session.clear
  end



end
