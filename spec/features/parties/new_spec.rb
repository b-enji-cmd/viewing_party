require 'rails_helper'

RSpec.describe 'As Authenticated User' do
  describe 'When I visit the new viewing party page' do
    before :each do
      # get a movie object saved here as test setup, below is temporary?
      @movie = Movie.create!(title: "The Fake Film of Movie")

      visit new_party_path
    end

    it 'I see the the name of the movie title rendered above a form' do
      within(".new-party-title") do
        expect(page).to have_content(@movie.title)
      end
    end

    it 'and duration of Party with a default value of movie runtime in minutes; a viewing party should NOT be created if set to a value less than the duration of the movie' do
    end

    it 'When: field to select date' do
    end

    it 'Start Time: field to select time' do
    end

    it 'Checkboxes next to each friend (if user has friends)' do
    end

    it 'Button to create a party' do
    end

    it 'and when I click create button, I am redirected back to my dashboard where I see the newly created event' do
    end

    it 'and  my event should be seen by any friends that were invited once they long in' do
    end
  end

end
