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
    u.username = params[:username]
    u.password = params[:password]
    u.save
  end

  get '/users/:id' do
    @user = User.find(params[:id])
    erb :'/users/show'
  end 

end
