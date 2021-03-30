class MoviesController < ApplicationController
  def index
    @returned_movies = if params[:q] == 'top_rated'
                         MovieService.top_movies
                       else
                         MovieService.search_movie(params[:q])
                       end
  end

  def show
    @movie = MovieService.find_movie(params[:id])
    #@reviews = MovieService.reviews(@movie.api_id)
    #@cast = MovieService.cast(@movie.api_id)
  end
end
