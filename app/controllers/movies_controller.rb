class MoviesController < ApplicationController
  def index
    @returned_movies = if params[:q] == 'top_rated'
                         MovieService.top_movies
                       else
                         MovieService.search_movie(params[:q])
                       end
  end

  def show
    binding.pry
    #@movie = MovieService.find_movie(params[:db_id])
  end

end