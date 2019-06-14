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
    erb :'/reviews/show'
  end

  get '/reviews/:id/edit' do
    if logged_in?(session)
      @review = Review.find(params[:id])
      if current_user(session) == @review.user
        erb :'/reviews/edit'
      else
        redirect '/reviews'
      end
    else
      redirect '/login'
    end
  end

  patch '/reviews/:id' do
    #binding.pry
    review = Review.find(params[:id])
    if logged_in?(session)

      if current_user(session) == review.user
        review.rating = params[:rating]
        review.content = params[:content]
        if review.save
          redirect "reviews/#{review.id}"
        else
          redirect "/reviews/#{review.id}/edit"
        end
      else
        redirect '/reviews'
      end
    else
      redirect '/login'
    end
  end

  post '/reviews/:id/delete' do
    @review = Review.find(params[:id])
    if current_user(session) == @review.user
      binding.pry
      @review.destroy
      redirect '/reviews'
    else
      redirect '/reviews'
    end
  end

end
