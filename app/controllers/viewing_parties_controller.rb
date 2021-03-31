class ViewingPartiesController < ApplicationController
  def new
    @movie = Movie.create!(api_id: params[:info][:api_id].to_i, title: params[:info][:title], duration: params[:info][:duration].to_i) if Movie.find_by(api_id: params[:api_id]).nil?
    @party = Party.new
  end


  def create
    # send the movie and user through a cookie
    @movie = Movie.find_by(api_id: params[:api_id])
    binding.pry
    if params[:duration] >= @movie.duration
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
