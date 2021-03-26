class MoviesController < ApplicationController
  def index
    if params[:top_rated]
      #@top_movies = MovieService.top_movies
    else
      # @matching_movies = MovieService.search_movie(params[:q])
    end

  end

  def show
  end
end