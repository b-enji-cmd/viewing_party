class PartiesController < ApplicationController
  def new
    # send the movie and user through a cookie
    @party = Party.new
  end


  def create
    # send the movie and user through a cookie
    if params[:duration] #>= @movie.length
      @party = Party.create!(
                          duration: params[:duration],
                          date: params[:date],
                          start_time: params[:start_time]
                        )
      flash.notice = "Your party has been created!"
      redirect_to dashboard_path
    else
      flash.notice = "Party's duration cannot be less than the movie duration" #(#{@movie.length})
    end
  end
end
