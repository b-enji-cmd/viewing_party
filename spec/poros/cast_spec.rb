require 'rails_helper'

RSpec.describe Cast do
	before :each do
		cast_data = {
			name: "Dumblegrid",
			character: "Silly Ol' Bear"
		}
		@cast = Cast.new(cast_data)
	end

  describe "attributes" do
  	it "should have attributes" do
  		expect(@cast.name).to eq "Dumblegrid"
  		expect(@cast.character).to eq "Silly Ol' Bear"
  	end
  end
end
