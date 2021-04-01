require 'rails_helper'

RSpec.describe Moovee do
	before :each do
		movie_data = {
			genres: [{id: 1, name: "Action"} , {id: 2, name: "Adventure"}, {id: 3, name: "Romance"}]
		}
		@movie = Moovee.new(movie_data)
	end

  describe "instance methods" do
  	it "#genres" do
  		expect(@movie.genres).to eq(%w(Action Adventure Romance))
  	end
  end
end
