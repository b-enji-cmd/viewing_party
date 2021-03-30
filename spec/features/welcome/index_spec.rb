require 'rails_helper'

RSpec.describe 'Welcome Page' do
  it 'Displays welcome message and brief description of app' do
    visit root_path

    expect(page).to have_content('Welcome to Viewing Party')

    description = 'Within this app, you will be able to explore movies and create a viewing party event for you and your friends to watch a movie together.'

    expect(page).to have_content(description)
  end

  it 'Contains button to sign in' do
    visit root_path

    expect(page).to have_button('Sign In')
  end

  it 'Contains link to register that brings me to registration form' do
    visit root_path

    expect(page).to have_link('New to Viewing Party? Register Here')
  end
end
