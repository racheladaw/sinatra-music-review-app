class ReviewsController < ApplicationController

  get '/reviews' do
    if logged_in?(session)
      @last_five_reviews = Review.last(5)
      erb :'/reviews/index'
    else
      redirect '/login'
    end
  end

  get '/reviews/new' do
    if logged_in?(session)
      @albums = Album.all
      erb :'/reviews/new'
    else
      redirect '/login'
    end
  end

  post '/reviews' do
    @albums = Album.all
    if logged_in?(session)
      album = Album.find(params[:album_id])
      r = Review.new(rating: params[:rating], content: params[:content])
      if r.save
        current_user(session).reviews << r
        album.reviews << r
        redirect '/reviews'
      else
        flash.now[:message] = "Please fill out all fields"
        erb :'/reviews/new'
      end
    else
      redirect '/login'
    end
  end

  get '/reviews/:id' do
    if logged_in?(session)
      @review = Review.find(params[:id])
      erb :'/reviews/show'
    else
      redirect '/login'
    end
  end

  get '/reviews/:id/edit' do
    if logged_in?(session)
      @review = Review.find(params[:id])
      if current_user(session) == @review.user
        erb :'/reviews/edit'
      else
        flash.now[:message] = "You can't edit another user's reviews"
        erb :'/reviews/show'
      end
    else
      redirect '/login'
    end
  end

  patch '/reviews/:id' do
    @review = Review.find(params[:id])
    if logged_in?(session)

      if current_user(session) == @review.user
        @review.rating = params[:rating]
        @review.content = params[:content]
        if @review.save
          redirect "reviews/#{@review.id}"
        else
          flash.now[:message] = "You must fill out all fields"
          erb :'/reviews/edit'
        end
      else
        flash.now[:message] = "You can't edit another user's reviews"
        erb :'/reviews/show'
      end
    else
      redirect '/login'
    end
  end

  post '/reviews/:id/delete' do
    if logged_in?(session)
      @review = Review.find(params[:id])
      if current_user(session) == @review.user
        #binding.pry
        @review.destroy
        redirect '/reviews'
      else
        flash.now[:message] = "You can't delete another user's reviews"
        erb :'/reviews/show'
      end
    else
      redirect '/login'
    end
  end

end
