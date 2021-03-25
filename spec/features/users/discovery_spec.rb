require 'rails_helper'

RSpec.describe 'Authenticated User' do
  before :each do
    @user = User.create!(email: "ben@example.com", password: "verysecure")
    visit root_path

    click_button "Sign In"
    fill_in :email, with: @user.email
    fill_in :password, with: 'verysecure'

    click_button "Sign In"
    click_button "Discover Movies"
  end

  describe "discovery page" do
    it "should take me to the discover page" do
      expect(current_path).to eq(discover_path)
    end
    it "should have a button to discover the top 40 movies" do
      expect(page).to have_button "Find Top Rated Movies"
    end

    it "should have a text field to search by movie title" do
      within("#movie-search") do
        expect(page).to have_content "Search for:"
      end
    end

    it "should have a button to search by movie title" do
      within("#movie-search") do
        expect(page).to have_button "Search"
      end
    end

    it "should take me to the movies page after clicking either" do
      #TODO
    end
  end
end
