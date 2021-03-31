require 'rails_helper'

RSpec.describe 'As Authenticated User' do
  describe 'When I visit the new viewing party page' do
    before :each do
      @user = User.create!(email: "winner@email.fr", password: "hellomovies2021")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it 'I see the the name of the movie title rendered above a form' do
      VCR.use_cassette('dark_phoenix_detail_page') do
        visit('/movies/320288')



        body = File.read('spec/fixtures/vcr_cassettes/dark_phoenix_detail_page.json')
        json_response = JSON.parse(body, symbolize_names: true)
        test = JSON.parse(json_response[:http_interactions][0][:response][:body][:string], symbolize_names: true )

        @movie = Moovee.new(test)

        click_link 'Create Viewing Party for Movie'

        expect(page).to have_content("Your Viewing Party Details")

        #within(".new-party-form") do
          #expect(page).to have_field('input[type="text"]')
       # end
      end
    end

    it 'and duration of Party with a default value of movie runtime in minutes' do
      visit viewing_parties_new_path

      within(".new-party-form") do
        expect(page).to have_field("party[duration]")
        expect(find_field("party[duration]").value).to eq(@movie.runtime)
      end
    end

    it 'a viewing party should NOT be created if duration is set to a value less than the duration of the movie' do
      visit viewing_parties_new_path

      fill_in "party[duration]", with: 10
      click_button("Create Party")

      expect(page).to have_content("Your duration cannot be less than #{@movie.runtime}")
    end

    it 'When: field to select date' do
      visit viewing_parties_new_path

      within(".new-party-form") do
        expect(page).to have_field("party[date]")
      end
    end

    it 'Start Time: field to select time' do
      visit viewing_parties_new_path

      within(".new-party-form") do
        expect(page).to have_field("party[start_time]")
      end
    end

    it 'Checkboxes next to each friend (if user has friends)' do
      visit viewing_parties_new_path

      # within(".new-party-form") do
      #   page.has_unchecked_field?
      # end
    end

    it 'and if user has no friends a button to add friends' do
      visit viewing_parties_new_path

      # within(".new-party-form") do
      #   expect(page).to have_button("Add Friend")
      # end
    end

    it 'Button to create a party' do
      visit viewing_parties_new_path

      within(".new-party-form") do
        expect(page).to have_button("Create Party")
      end
    end

    it 'and when I click create button, I am redirected back to my dashboard where I see the newly created event' do
      visit viewing_parties_new_path


      click_button("Create Party")

      # expect(current_path).to eq(dashboard_path)
      # expect(page).to have_content("placeholder for @movie.title")
    end

    it 'and  my event should be seen by any friends that were invited once they long in' do
      visit viewing_parties_new_path

    end
  end

end
