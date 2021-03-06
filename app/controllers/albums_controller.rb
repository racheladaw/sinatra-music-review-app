class AlbumsController < ApplicationController

  get '/albums' do
    if logged_in?(session)
      @albums = Album.all
      erb :'/albums/index'
    else
      redirect '/login'
    end
  end

  get '/albums/new' do
    if logged_in?(session)
      erb :'/albums/new'
    else
      redirect '/login'
    end
  end

  post '/albums' do
    if logged_in?(session)
      a = Album.new(name: params[:name], artist: params[:artist], release_date: params[:release_date])
      if a.save
        redirect '/albums'
      else
        flash.now[:message] = "Please fill out all fields. Album must not already exist."
        erb :'/albums/new'
      end
    else
      redirect '/login'
    end
  end

  get '/albums/:slug' do
    if logged_in?(session)
      @album = Album.find_by_slug(params[:slug])
      erb :'/albums/show'
    else
      redirect '/login'
    end
  end

end
