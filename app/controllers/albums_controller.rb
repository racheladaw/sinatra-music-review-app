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
    a = Album.new(name: params[:name], artist: params[:artist], release_date: params[:release_date])
    # Album.all.each do |album|
    #   if params[:name] == album.name
    #     redirect '/albums/new'
    #   end
    # end
    # r = Review.new(rating: params[:rating], content: params[:content])
    if a.save
    # current_user(session).reviews << r
    # a.reviews << r
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
