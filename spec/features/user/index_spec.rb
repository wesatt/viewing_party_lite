# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User Index Page', type: :feature do
  describe 'landing page' do
    it 'has the title of the application and exists as our landing page' do
      visit '/'

      expect(page).to have_content('Viewing Party Lite')
    end

    it 'has a button to create a new user' do
      visit root_path

      click_button 'Create a New User'

      expect(current_path).to eq('/register')
    end

    it 'has a list of existing users as links to the user dashboard' do
      oakley = User.create!(name: 'Oakley', email: 'good_dog@gmail.com', password: 'test123')
      kona = User.create!(name: 'Kona', email: 'goodd_dog@gmail.com', password: 'test123')
      hazel = User.create!(name: 'Hazel', email: 'a_dog@gmail.com', password: 'test123')

      visit root_path

      expect(page).to have_link("#{oakley.email}'s Dashboard")
      expect(page).to have_link("#{kona.email}'s Dashboard")

      click_link("#{hazel.email}'s Dashboard")

      expect(current_path).to eq("/users/#{hazel.id}")
    end

    it 'has a link to go back to the landing/user index page' do
      visit root_path

      click_link 'Home'

      expect(current_path).to eq(root_path)

      click_button 'Create a New User'

      expect(current_path).to eq(register_path)

      click_link 'Home'

      expect(current_path).to eq(root_path)
    end
  end
end
