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


        expect(page).to have_link('Create Viewing Party for Movie')

        @movie = Moovee.new(json_response)
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
  end
end
