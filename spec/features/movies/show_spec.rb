require 'rails_helper'

RSpec.describe 'Authenticated User' do
  before :each do
    @user = User.create!(email: "ben@example.com", password: "verysecure")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    # visit root_path
    #
    # click_button "Sign In"
    # fill_in :email, with: @user.email
    # fill_in :password, with: 'verysecure'
    #
    # click_button "Sign In"

  end

  describe "movie show page" do
    it "have button to create viewing party" do
      VCR.use_cassette('dark_phoenix_detial_page') do
        visit movies_path({id: 320288})

        expect(current_path).to eq(movies_path)

        expect(page).to have_link('Create Viewing Part for Movie')
      end
    end
  end
end
