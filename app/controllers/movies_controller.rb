class MoviesController < ApplicationController
  def index
    if params[:top_rated]
      @returned_movies = MovieService.top_movies
    elsif params[:q]
      @returned_movies = MovieService.search_movie(params[:q])
    end
  end

  def show
    @movie = MovieService.find_movie(params[:db_id])
  end

end