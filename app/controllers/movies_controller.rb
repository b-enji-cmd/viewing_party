class MoviesController < ApplicationController
  def index
    binding.pry
    @returned_movies = if params[:q] == 'top_rated'
                         MovieService.top_movies
                       else
                         MovieService.search_movie(params[:q])
                       end


  end

  def show
    @movie = MovieService.find_movie(params[:id])
  end

end
