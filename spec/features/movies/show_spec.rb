require 'rails_helper'

RSpec.describe 'Authenticated User' do
  before :each do
    @user = User.create!(email: "ben@example.com", password: "verysecure")
    visit root_path

    click_button "Sign In"
    fill_in :email, with: @user.email
    fill_in :password, with: 'verysecure'

    click_button "Sign In"

  end

  describe "movie show page" do
    it "should show attributes of the movie" do

    end
  end
end
