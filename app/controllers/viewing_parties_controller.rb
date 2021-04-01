class ViewingPartiesController < ApplicationController
  def new
    @movie = Movie.create!(api_id: params[:info][:api_id].to_i, title: params[:info][:title], duration: params[:info][:duration].to_i) if Movie.find_by(api_id: params[:api_id]).nil?

    @party = Party.new

    @friends = current_user.friends ####
  end


  def create
    @movie = Movie.find_by(api_id: params[:api_id].to_i)

    if params[:duration].to_i >= @movie.duration
      @party = Party.create!(
                          movie_title: @movie.title,
                          api_id: @movie.api_id,
                          duration: params[:duration],
                          date: params[:date],
                          start_time: params[:start_time],
                          user_id: current_user.id
                        )
      current_user.parties << @party
      binding.pry
      flash.notice = "Your party has been created!"
      redirect_to dashboard_path
    else
      flash.notice = "Party's duration cannot be less than the movie duration (#{@movie.duration} minutes)"
      render :new
    end
  end
end
