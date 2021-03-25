require 'rails_helper'

RSpec.describe 'As Authenticated User' do
  describe 'When I visit the new viewing party page' do
    before :each do
      # get a movie object saved here as test setup, below is temporary?
      # @movie = Movie.create!(title: "The Fake Film of Movie")

      visit new_party_path
    end

    xit 'I see the the name of the movie title rendered above a form' do

      expect(page).to have_content("Your Viewing Party Details")

      within(".new-party-form") do
        expect(page).to have_content(@movie.title)
      end
    end

    it 'and duration of Party with a default value of movie runtime in minutes; a viewing party should NOT be created if set to a value less than the duration of the movie' do

      within(".new-party-form") do
        expect(page).to have_field(:duration)
        # 15 below is a placeholder for @movie.length
        expect(find_field(:duration).value).to eq("15")
      end
      #create test for changing duration to less than movie duration and prompting message that it cannot!
    end

    it 'When: field to select date' do

      within(".new-party-form") do
        expect(page).to have_field(:date)
      end
    end

    it 'Start Time: field to select time' do
      within(".new-party-form") do
        expect(page).to have_field(:start_time)
      end
    end

    it 'Checkboxes next to each friend (if user has friends)' do
    end

    it 'and if user has no friends a button to add friends' do 
    end

    it 'Button to create a party' do
      within(".new-party-form") do
        expect(page).to have_button("Create Party")
      end
    end

    it 'and when I click create button, I am redirected back to my dashboard where I see the newly created event' do
    end

    it 'and  my event should be seen by any friends that were invited once they long in' do
    end
  end

end
