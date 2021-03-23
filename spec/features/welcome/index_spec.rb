require 'rails_helper'

RSpec.describe 'Welcome Page' do
  it 'Displays welcome message and brief description of app' do
    visit root_path

    expect(page).to have_content("Welcome to Viewing Party")

    description = "Within this app, you will be able to explore movies and create a viewing party event for you and your friends to watch a movie together."

    expect(page).to have_content(description)
  end

  it 'Contains link to register that brings me to registration form' do
    visit root_path

    expect(page).to have_link("New to Viewing Party? Register Here")

    click_link("New to Viewing Party? Register Here")

    expect(current_path).to eq(registration_path)
  end

  it 'When I fill out new user form correctly, I am brought to user Dashboard' do
    visit root_path

    click_link("New to Viewing Party? Register Here")

    email = "example@email.com"
    password = "turingschool"

    fill_in :email, with: email
    fill_in :password, with: password
    fill_in :password_confirmation, with: password

    click_on "Register"

    expect(current_path).to eq(dashboard_path)
  end
end
