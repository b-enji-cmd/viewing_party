require 'rails_helper'

RSpec.describe 'As Authenticated User' do
  describe 'When I visit the new viewing party page' do
    before :each do
      @user = User.create!(email: "winner@email.fr", password: "hellomovies2021")
      @user_1 = User.create!(email: "loser@email.fr", password: "superduper")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      visit('/movies/320288')

      body = File.read('spec/fixtures/vcr_cassettes/dark_phoenix_detail_page.json')
      json_response = JSON.parse(body, symbolize_names: true)
      test = JSON.parse(json_response[:http_interactions][0][:response][:body][:string], symbolize_names: true )

      @movie = Moovee.new(test)
    end

    it 'I see the the name of the movie title rendered above a form' do
      VCR.use_cassette('dark_phoenix_detail_page') do
        click_link 'Create Viewing Party for Movie'

        expect(page).to have_content("Your Viewing Party Details")
      end
    end

    it 'and duration of Party with a default value of movie runtime in minutes' do
       VCR.use_cassette('dark_phoenix_detail_page') do
        click_link 'Create Viewing Party for Movie'

        within(".new-party-form") do
          expect(page).to have_xpath("/html/body/main/section/form/input[4]")
        end
      end
    end

    it 'a viewing party should NOT be created if duration is set to a value less than the duration of the movie' do
      VCR.use_cassette('dark_phoenix_detail_page') do
        click_link 'Create Viewing Party for Movie'
        fill_in "duration", with: 0
        click_button("Create Party")

      end
        expect(page).to have_content("Party's duration cannot be less than the movie duration (#{@movie.runtime} minutes)")
    end

    it 'When: field to select date' do
      VCR.use_cassette('dark_phoenix_detail_page') do
        click_link 'Create Viewing Party for Movie'
        within(".new-party-form") do
          expect(page).to have_field("date")
        end
      end
    end

    it 'Start Time: field to select time' do
      VCR.use_cassette('dark_phoenix_detail_page') do
        click_link 'Create Viewing Party for Movie'
        within(".new-party-form") do
          expect(page).to have_field("start_time")
        end
      end
    end

    it 'Checkboxes next to each friend (if user has friends)' do
      VCR.use_cassette('dark_phoenix_detail_page') do
        UserFriend.create!(user_id: @user.id, friend_id: @user_1.id)

        click_link 'Create Viewing Party for Movie'
        expect(page).to have_xpath("/html/body/main/section/form/input[8]")
        expect(page).to have_unchecked_field("#{@user_1.email}")
      end
    end

    it 'Button to create a party' do
      VCR.use_cassette('dark_phoenix_detail_page') do
        click_link 'Create Viewing Party for Movie'
        within(".new-party-form") do
          expect(page).to have_button("Create Party")
        end
      end
    end

    it 'and when I click create button, I am redirected back to my dashboard where I see the newly created event' do
        VCR.use_cassette('dark_phoenix_detail_page') do
        click_link 'Create Viewing Party for Movie'
        fill_in "duration", with: 200
        fill_in :date , with: '2020-01-01' # there has to be a better way to get it to format correctly
        fill_in "start_time", with: 111111 #again, if theres a better way to get it to fill in the AM / PM thing PLEASE let me know
        click_button("Create Party")

        end
        expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("#{@movie.title}")
    end

    it 'and  my event should be seen by any friends that were invited once they long in' do
      VCR.use_cassette('dark_phoenix_detail_page') do
        UserFriend.create!(user_id: @user.id, friend_id: @user_1.id)

        click_link 'Create Viewing Party for Movie'
        fill_in "duration", with: 200
        fill_in :date , with: '2020-01-01' # there has to be a better way to get it to format correctly
        fill_in "start_time", with: 111111 #again, if theres a better way to get it to fill in the AM / PM thing PLEASE let me know
        check "#{@user_1.email}"
        click_button("Create Party")

        visit root_path


        click_button "Sign In"

        fill_in "email", with: @user_1.email
        fill_in "password", with: @user_1.password

        click_button("Sign In")

        expect(page).to have_link("#{@movie.title}")
      end
    end

  end
  end
