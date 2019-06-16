class AlbumsController < ApplicationController

  get '/albums' do
    @albums = Album.all
    erb :'/albums/index'
  end

  get '/albums/new' do
    erb :'/albums/new'
  end

  post '/albums' do
    a = Album.new(name: params[:name], artist: params[:artist], release_date: params[:release_date])
    if a.save
      redirect '/albums'
    else
      redirect '/albums/new'
    end
  end

  get '/albums/:slug' do
    @album = Album.find_by_slug(params[:slug])
    erb :'/albums/show'
  end
end
