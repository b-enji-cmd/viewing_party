class PartiesController < ApplicationController
  def new
    binding.pry
    @movie =
    
    binding.pry
    @party = Party.new
  end


  def create
    # send the movie and user through a cookie
    if params[:duration] >= @movie.runtime
      @party = Party.create!(
                          duration: params[:duration],
                          date: params[:date],
                          start_time: params[:start_time]
                        )
      flash.notice = "Your party has been created!"
      redirect_to dashboard_path
    else
      flash.notice = "Party's duration cannot be less than the movie duration (#{@movie.runtime})"
    end
  end
end
