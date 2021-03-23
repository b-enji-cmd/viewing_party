require 'rails_helper'

RSpec.describe 'Welcome Page' do
  it 'Displays welcome message and brief description of app' do
    visit root_path

    expect(page).to have_content("Welcome to Viewing Party")

    expect(page).to have_content("Brief description of app")
  end

end
