require 'rails_helper'

RSpec.describe 'Authenticated User' do
  before :each do
    @user = User.create!(email: "ben@example.com", password: "verysecure")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  describe "movie show page" do
    it "have button to create viewing party and display movie details" do

      VCR.use_cassette('dark_phoenix_detail_page') do
        visit('/movies/320288')
        body = File.read('spec/fixtures/vcr_cassettes/dark_phoenix_detail_page.json')
        json_response = JSON.parse(body, symbolize_names: true)
        test = JSON.parse(json_response[:http_interactions][0][:response][:body][:string], symbolize_names: true )

        expect(page).to have_link('Create Viewing Party for Movie')

        @movie = Moovee.new(test)
        expect(page).to have_content(@movie.title)

        within("#movie-details") do
          expect(page).to have_content(@movie.vote_average)
          expect(page).to have_content(@movie.runtime)
          @movie.genres.each do |genre|
            expect(page).to have_content(genre)
          end
        end

        within("#movie-summary") do
          expect(page).to have_content(@movie.summary)
        end

      end
    end

    it "should display information about the cast" do
     VCR.use_cassette('dark_phoenix_cast_details') do
        visit('/movies/320288')
        within("#cast-section") do
          within("#member-0") do
            expect(page).to have_content("Sophie Turner as Jean Grey / Dark Phoenix")
          end
        end
      end
    end

    it "should display information about the reviews" do
      VCR.use_cassette('dark_phoenix_review_details') do
        visit('/movies/320288')
        expect(page).to have_content "8 Reviews"
        within("#reviews") do
          within("#review-0") do
            expect(page).to have_content("SWITCH.")
            expect(page).to have_content("It’s just a shame") #what a way to start a review
          end
        end
      end
    end
  end
end
