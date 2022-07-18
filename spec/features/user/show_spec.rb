# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'The User Show Page', type: :feature do
  describe 'dashboard' do
    it 'has the users name in the title' do
      user = User.create!(name: 'Rand', email: 'randalthor@gmail.com', password: 'test123')

      visit "/users/#{user.id}"

      expect(page).to have_content('Viewing Party Lite')
      expect(page).to have_content("#{user.name}'s Dashboard")
    end

    it 'has a button to discover movies' do
      user = User.create!(name: 'Rand', email: 'randalthor@gmail.com', password: 'test123')

      visit "/users/#{user.id}"

      click_button 'Discover Movies'

      expect(current_path).to eq("/users/#{user.id}/discover")
    end

    it 'has a section that lists viewing parties' do
      user = User.create!(name: 'Rand', email: 'randalthor@gmail.com', password: 'test123')
      # will need to add more to this test, select a movie, create a view party etc.

      visit "/users/#{user.id}"

      expect(page).to have_content('Viewing Parties')
    end
  end
end
