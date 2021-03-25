require 'rails_helper'

RSpec.describe 'Authenticated User' do
  before :each do
    @user = User.create!(email: "ben@example.com", password: "verysecure")
    visit root_path

    click_button "Sign In"
    fill_in :email, with: @user.email
    fill_in :password, with: 'verysecure'

    click_on "Sign In"
  end

  describe "dashboard page" do
    it "displays a welcome message" do
      expect(page).to have_content "Welcome #{@user.email}!"
    end

    it 'and a button to discover movies' do
      expect(page).to have_button "Discover Movies"
    end

    it 'has a friends section' do
      within(".friends-section") do
        expect(page).to have_content("Friends")
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
      within(".friends-section") do
        expect(page).to have_field(:email, placeholder: 'Search by email')
        expect(page).to have_button("Add Friend")
      end
    end

    it 'defaults to no friends' do
      within(".friends-section") do
        expect(page).to have_content("You currently have no friends.")
      end
    end

    it 'when I add an email that is in the database, it gets added to the friends list' do
      new_friend = User.create!(email: "new@email.com", password: "superssecret")
      UserFriend.create!(user_id: @user.id, friend_id: new_friend.id)

      within(".friends-section") do
        expect(page).to_not have_content(new_friend.email)

        fill_in 'email', with: new_friend.email

        click_button "Add Friend"

        expect(page).to have_content(new_friend.email)
        expect(page).to_not have_content("You currently have no friends.")
      end
    end

    it 'when I add an email that is not in the database, I see a flash message' do
      non_existing_friend = "example@email.com"

      within(".friends-section") do
        fill_in 'email', with: non_existing_friend
        click_button "Add Friend"
      end

      expect(page).to have_content("That user does not exist")
    end

    it 'search in not case sensitive' do
      another_friend = User.create!(email: "another@email.com", password: "superssecret")
      UserFriend.create!(user_id: @user.id, friend_id: another_friend.id)

      within(".friends-section") do
        expect(page).to_not have_content(another_friend.email)

        fill_in 'email', with: "AnOtHeR@email.com"

        click_button "Add Friend"
        save_and_open_page
        expect(page).to have_content(another_friend.email)
        expect(page).to_not have_content("You currently have no friends.")
      end
    end
  end
end
