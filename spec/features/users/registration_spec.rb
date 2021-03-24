require 'rails_helper'

RSpec.describe 'User Registration' do
  it 'When I click register link I am brought to registration form' do
    visit root_path

    click_link("New to Viewing Party? Register Here")

    expect(current_path).to eq(registration_path)
  end

  it 'When I fill out new user form correctly, I am brought to user Dashboard' do
    visit root_path

    click_link("New to Viewing Party? Register Here")

    email = "example@email.com"
    password = "turingschool"

    fill_in 'user[email]', with: email
    fill_in "user[password]", with: password
    fill_in "user[password_confirmation]", with: password

    click_on "Register"

    expect(current_path).to eq(dashboard_path)
  end

  it 'Requires all fields to be filled out' do
    visit registration_path

    click_on "Register"

    expect(current_path).to eq(users_path)

    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content("Password can't be blank")
  end

  it 'validates the email format' do
    visit registration_path

    fill_in "user[email]", with: "iloveMovies.com"
    fill_in "user[password]", with: "password"
    fill_in "user[password_confirmation]", with: "password"

    click_on "Register"

    expect(page).to have_content("Email is invalid")
	end

	it 'confirms email uniqueness' do
    visit registration_path

    email = "name@email.com"
    password = "helloworld"

    fill_in "user[email]", with: email
    fill_in "user[password]", with: password
    fill_in "user[password_confirmation]", with: password

    click_on "Register"

    visit registration_path

    fill_in "user[email]", with: email
    fill_in "user[password]", with: "password"
    fill_in "user[password_confirmation]", with: "password"

    click_on "Register"

    expect(page).to have_content("Email has already been taken")
	end

  xit 'validates that passwords match' do
    visit registration_path

    fill_in "user[email]", with: "coffeez@email.com"
    fill_in "user[password]", with: "hellomovies"
    fill_in "user[password_confirmation]", with: "filmnerd03"

    click_on "Register"

    expect(page).to have_content("Password confirmation failed, passwords must match. Please try again.
")
  end

  it 'validates password minimum length' do
    visit registration_path

    fill_in "user[email]", with: "magickalmugs@email.com"
    fill_in "user[password]", with: "films"
    fill_in "user[password_confirmation]", with: "films"

    click_on "Register"

    expect(page).to have_content("Password is too short (minimum is 8 characters)")
  end
end
