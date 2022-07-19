# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "The User's Discover Movies Page", type: :feature do
  it 'has VPL title and discover movies at the top' do
    user = User.create!(name: 'Rand', email: 'randalthor@gmail.com', password: 'test123')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/dashboard'
    click_button 'Discover Movies'

    expect(current_path).to eq('/discover')
    expect(page).to have_content('Viewing Party Lite')
    expect(page).to have_content('Discover Movies')
  end

  it 'has a button that returns top rated movies', :vcr do
    user = User.create!(name: 'Rand', email: 'randalthor@gmail.com', password: 'test123')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/discover'

    click_button 'Find Top Rated Movies'

    expect(current_path).to eq('/movies')
    # expect(page).to have_content("Vote Average")
  end

  it 'has a search field based on keyword', :vcr do
    user = User.create!(name: 'Rand', email: 'randalthor@gmail.com', password: 'test123')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/discover'

    fill_in :q, with: 'Fight'
    click_button 'Find Movies'

    expect(page).to have_content('Fight Club')
  end
end
