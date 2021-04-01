require 'rails_helper'

RSpec.describe 'Authenticated User' do
  before :each do
    @user = User.create!(email: "ben@example.com", password: "verysecure")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    visit discover_path

  end

  describe "movie index page" do
    it "should display top rated movies" do
      VCR.use_cassette('top_rated_page') do
        click_button "Find Top Rated Movies"
        within("#returned-movies") do

          expect(page).to have_link("Dilwale Dulhania Le Jayenge")
          expect(page).to have_content("Dilwale Dulhania Le Jayenge")
          expect(page).to have_content("Vote Average: 8.7")
        end
      end
    end

    it "should display searched movies" do
      VCR.use_cassette('search_results_page') do
        within("#movie-search") do
          fill_in :q , with: "Phoenix"
          click_button "Search"
        end

        within("#returned-movies") do
          expect(page).to have_link("Dark Phoenix")
          expect(page).to have_content("Dark Phoenix")
          expect(page).to have_content("Vote Average: 6.1")
        end
      end
    end
  end
end
