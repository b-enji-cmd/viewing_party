require 'rails_helper'

RSpec.describe 'Authenticated User' do
  before :each do
    visit root_path

    click_link("New to Viewing Party? Register Here")

    @email = "example@email.com"
    @password = "turingschool"

    fill_in 'user[email]', with: @email
    fill_in "user[password]", with: @password
    fill_in "user[password_confirmation]", with: @password

    click_on "Register"
  end

  describe "dashboard page" do
    it "displays a welcome message" do
      expect(page).to have_content "Welcome #{@email}!"
    end

    it 'and a button to discover movies' do
      expect(page).to have_button "Discover Movies"
    end

    it 'has a friends section' do
      within(".friends-section") do
        expect(page).to have_content("Placeholder!")
      end
    end


    it 'has a viewing party section' do
      within(".viewing-parties") do
        expect(page).to have_content("Placeholder!")
      end
    end
  end
  
  describe "friends section" do
    it 'has search field and button to add friend' do
      within (".friends-section") do
        expect(page).to have_field(:email, placeholder: 'Search by email')
        expect(page).to have_button("Add Friend")
      end
    end
  end
end
