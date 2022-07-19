# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'The User Movies Index page' do
  describe 'top rated movies' do
    it 'has a list of top rated movies', :vcr do
      oakley = User.create!(name: 'Oakley', email: 'good_dog@gmail.com', password: 'test123')

      visit "/discover"

      click_button 'Find Top Rated Movies'

      # expect(current_path).to eq("/users/#{oakley.id}/movies?q=top%20rated")
      expect(current_path).to eq("/movies")
      expect(page).to have_content('Viewing Party Lite')
      expect(page).to have_content('Top Rated Movies')
      expect(page).to have_content('Vote Average:')
    end
  end

  describe 'movies search feature' do
    it 'can search for movies based on search criteria', :vcr do
      oakley = User.create!(name: 'Oakley', email: 'good_dog@gmail.com', password: 'test123')

      visit "/discover"

      fill_in :q, with: 'top gun'
      click_button 'Find Movies'

      # expect(current_path).to eq("/users/#{oakley.id}/movies?q=keyword")
      expect(current_path).to eq("/movies")
      expect(page).to have_content('Viewing Party Lite')
      expect(page).to have_content('Movie results for:')
      expect(page).to have_content('Vote Average:')
      expect(page).to_not have_content('Fight Club')
      expect(page).to have_content('Top Gun')
    end

    it 'will not run if search field is blank', :vcr do
      oakley = User.create!(name: 'Oakley', email: 'good_dog@gmail.com', password: 'test123')

      visit "/discover"

      # fill_in :q, with: ""
      click_button 'Find Movies'

      expect(current_path).to eq("/discover")
      expect(page).to have_content('Search cannot be blank.')
    end
  end
end
