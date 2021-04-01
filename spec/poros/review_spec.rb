require 'rails_helper'

RSpec.describe Review do
	before :each do
		review_data = {
			author: "angry-boi",
			content: ">:("
		}
		@review = Review.new(review_data)
	end

  describe "attributes" do
  	it "should have attributes" do
  		expect(@review.author).to eq "angry-boi"
  		expect(@review.content).to eq ">:("
  	end
  end
end
