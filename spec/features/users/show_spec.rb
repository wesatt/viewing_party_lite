# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'The User Show Page', type: :feature do
  describe 'dashboard' do
    it 'has the users name in the title' do
      user = User.create!(name: 'Rand', email: 'randalthor@gmail.com', password: 'test123')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/dashboard'

      expect(page).to have_content('Viewing Party Lite')
      expect(page).to have_content("#{user.name}'s Dashboard")
    end

    it 'has a button to discover movies' do
      user = User.create!(name: 'Rand', email: 'randalthor@gmail.com', password: 'test123')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/dashboard'

      click_button 'Discover Movies'

      expect(current_path).to eq('/discover')
    end

    it 'has a section that lists viewing parties' do
      user = User.create!(name: 'Rand', email: 'randalthor@gmail.com', password: 'test123')
      # will need to add more to this test, select a movie, create a view party etc.
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/dashboard'

      expect(page).to have_content('Viewing Parties')
    end
  end
end
