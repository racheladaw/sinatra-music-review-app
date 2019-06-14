class ReviewsController < ApplicationController

  get '/reviews' do
    @last_five_reviews = Review.last(5)
    erb :'/reviews/index'
  end

  get '/reviews/new' do
    @albums = Album.all
    erb :'/reviews/new'
  end

  post '/reviews' do
    binding.pry
    if logged_in?(session)
      album = Album.find(params[:album_id])
      r = Review.new(rating: params[:rating], content: params[:content])
      if r.save
        current_user(session).reviews << r
        album.reviews << r
        redirect '/reviews'
      end
    else
      redirect '/login'
    end
  end

  get '/reviews/:id' do
    @review = Review.find(params[:id])
    erb :'reviews/show'
  end

end
