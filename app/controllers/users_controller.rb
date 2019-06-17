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
    u = User.new
    u.username = params[:username]
    u.password = params[:password]
    if u.save
      redirect '/login'
    else
      flash.now[:message] = "You must fill out all fields. Username can't already be in use."
      erb :'/users/new', :layout => false
    end
  end

  get '/users/:slug' do
    if logged_in?(session)
      @user = User.find_by_slug(params[:slug])
      erb :'/users/show'
    else
      redirect '/login'
    end
  end

  get '/login' do
    if !logged_in?(session)
      erb :'/users/login', :layout => false
    else
      @user = current_user(session)
      flash[:message] = "You're already logged in"
      erb :'/users/show'
    end
  end

  post '/login' do
    u = User.find_by(username: params[:username])
    if u && u.authenticate(params[:password])
      session[:user_id] = u.id
      redirect "/users/#{u.slug}"
    else
      flash.now[:message] = "Username or password is incorrect"
      erb :'/users/login', :layout => false
    end
  end

  get '/logout' do
    if logged_in?(session)
      session.clear
      redirect '/login'
    else
      redirect '/login'
    end
  end



end
