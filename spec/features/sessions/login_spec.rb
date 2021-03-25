require 'rails_helper'

RSpec.describe 'Existing User' do
  before :each do
    @user = User.create!(email: "ben@example.com", password: "verysecure")
    visit root_path

    click_button "Sign In"
  end

  describe "login page" do
    it "should have fields to fill out log in information" do
      expect(current_path).to eq(login_path)
      fill_in :email, with: @user.email
      fill_in :password, with: 'verysecure'

      click_button "Sign In"

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content "Welcome #{@user.email}!"
    end
  end
end
