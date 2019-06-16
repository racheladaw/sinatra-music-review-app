class UsersController < ApplicationController

  get '/users' do
    if logged_in?(session)
      @users = User.all
      erb :'/users/index'
    else
      redirect '/login'
    end
  end

  get '/signup' do
    if !logged_in?(session)
      erb :'/users/new', :layout => false
    else
      redirect "/users/#{current_user(session).slug}"
    end
  end

  post '/users' do
    #binding.pry
    u = User.new
    if !params[:username].empty?
      User.all.each do |user|
        if user.username == params[:username]
          redirect '/signup'
        end
      end
      u.username = params[:username]
      u.password = params[:password]
      if u.save
        redirect '/login'
      end
    else
      redirect '/signup'
    end
  end

  get '/users/:slug' do
    #binding.pry
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end

  get '/login' do
    #binding.pry
    if !logged_in?(session)
      erb :'/users/login', :layout => false
    else
      redirect "/users/#{current_user(session).slug}"
    end
  end

  post '/login' do
    #binding.pry
    u = User.find_by(username: params[:username])
    if u && u.authenticate(params[:password])
      session[:user_id] = u.id
      redirect "/users/#{u.slug}"
    else
      redirect '/login'
    end
  end

  get '/logout' do
    session.clear
    redirect '/login'
  end



end
