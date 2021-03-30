require 'rails_helper'

RSpec.describe 'As Authenticated User' do
  describe 'When I visit the new viewing party page' do
    before :each do
      @user = User.create!(email: "winner@email.fr", password: "hellomovies2021")

      visit root_path

      click_button "Sign In"
      fill_in :email, with: @user.email
      fill_in :password, with: 'hellomovies2021'
      click_button "Sign In"
      click_button "Discover Movies"
      fill_in :q, with: 'about you'
      click_button "Search"
      click_link "10 Things I Hate About You"
      click_button "Create a Viewing Party"
    end
    it 'I see the the name of the movie title rendered above a form' do
      visit new_party_path

      expect(page).to have_content("Your Viewing Party Details")

      within(".new-party-form") do
        expect(page).to have_content(@movie.title)
      end
    end

    it 'and duration of Party with a default value of movie runtime in minutes' do
      visit new_party_path

      within(".new-party-form") do
        expect(page).to have_field("party[duration]")
        expect(find_field("party[duration]").value).to eq(@movie.runtime)
      end
    end

    it 'a viewing party should NOT be created if duration is set to a value less than the duration of the movie' do
      visit new_party_path

      fill_in "party[duration]", with: 10
      click_button("Create Party")

      expect(page).to have_content("Your duration cannot be less than #{@movie.runtime}")
    end

    it 'When: field to select date' do
      visit new_party_path

      within(".new-party-form") do
        expect(page).to have_field("party[date]")
      end
    end

    it 'Start Time: field to select time' do
      visit new_party_path

      within(".new-party-form") do
        expect(page).to have_field("party[start_time]")
      end
    end

    it 'Checkboxes next to each friend (if user has friends)' do
      visit new_party_path

      # within(".new-party-form") do
      #   page.has_unchecked_field?
      # end
    end

    it 'and if user has no friends a button to add friends' do
      visit new_party_path

      # within(".new-party-form") do
      #   expect(page).to have_button("Add Friend")
      # end
    end

    it 'Button to create a party' do
      visit new_party_path

      within(".new-party-form") do
        expect(page).to have_button("Create Party")
      end
    end

    it 'and when I click create button, I am redirected back to my dashboard where I see the newly created event' do
      visit new_party_path


      click_button("Create Party")

      # expect(current_path).to eq(dashboard_path)
      # expect(page).to have_content("placeholder for @movie.title")
    end

    it 'and  my event should be seen by any friends that were invited once they long in' do
      visit new_party_path

    end
  end

end
