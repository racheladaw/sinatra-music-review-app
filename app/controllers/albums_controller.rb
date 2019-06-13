class AlbumsController < ApplicationController

  get '/albums' do
    @albums = Album.all
    erb :'/albums/index'
  end

  get '/albums/new' do
    erb :'/albums/new'
  end

  post '/albums' do
    #binding.pry
    if !params[:name].empty?
      a = Album.new
      Album.all.each do |album|
        if params[:name] == album.name
          redirect '/albums/new'
        end
      end
      a.name = params[:name]
      a.artist = params[:artist]
      a.release_date = params[:release_date]
      a.save
      # current_user(session).albums << a
      # current_user(session).save
      redirect '/albums'
    else
      redirect '/albums/new'
    end
  end
end
