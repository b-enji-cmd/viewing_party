require 'rails_helper'

RSpec.describe 'Authenticated User' do
  before :each do
    @user = User.create!(email: "ben@example.com", password: "verysecure")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  describe "movie show page" do
    it "have button to create viewing party and display movie details" do

      VCR.use_cassette('dark_phoenix_detail_page', :serialize_with => :json) do
        visit('/movies/320288')
        body = File.read('spec/fixtures/vcr_cassettes/dark_phoenix_detail_page.json')
        # response_body_for(:get, "http://localhost:3000/movies/3202888")
        json_response = JSON.parse(body, symbolize_names: true)
        test = JSON.parse(json_response[:http_interactions][0][:response][:body][:string], symbolize_names: true )

        expect(page).to have_link('Create Viewing Party for Movie')

        @movie = Moovee.new(test)
        expect(page).to have_content(@movie.title)
        expect(page).to have_content(@movie.vote_average)
        # expect(page).to have_content(movie_title.runtime)
        # expect(page).to have_content(movie_title.genre)
        # expect(page).to have_content(movie_title.summary)


      end
    end
  end
end
