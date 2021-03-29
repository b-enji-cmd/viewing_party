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

  describe "movie index page" do
    xit "should display top rated movies" do
      Movie.destroy_all
      click_button "Find Top Rated Movies"
    end

    xit "should display searched movies" do
      within("#movie-search") do
        fill_in :q , with: "Phoenix"
        click_button "Search"
      end
    end
  end
end
