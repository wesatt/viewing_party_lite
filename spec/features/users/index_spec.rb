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

    # it 'has a list of existing users as links to the user dashboard' do
    #   oakley = User.create!(name: 'Oakley', email: 'good_dog@gmail.com', password: 'test123')
    #   kona = User.create!(name: 'Kona', email: 'goodd_dog@gmail.com', password: 'test123')
    #   hazel = User.create!(name: 'Hazel', email: 'a_dog@gmail.com', password: 'test123')
    #   allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(hazel)

    #   visit root_path

    #   expect(page).to have_link("#{oakley.email}'s Dashboard")
    #   expect(page).to have_link("#{kona.email}'s Dashboard")

    #   click_link("#{hazel.email}'s Dashboard")

    #   expect(current_path).to eq('/dashboard')
    # end

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

  describe 'User Story #3 - Logging In Happy Path' do
    # As a registered user
    # When I visit the landing page `/`
    # I see a link for "Log In"
    # When I click on "Log In"
    # I'm taken to a Log In page ('/login') where I can input my unique email and password.
    # When I enter my unique email and correct password
    # I'm taken to my dashboard page
    it 'has a link to the login page that takes you to the user show page when correct info is entered' do
      user = User.create!(name: 'Christopher Lee', email: 'dracula@hammer.com', password: 'test123')
      visit '/'
      click_link('Log In')

      expect(current_path).to eq('/login')

      fill_in(:email, with: 'dracula@hammer.com')
      fill_in(:password, with: 'test123')
      click_button('Submit')

      expect(current_path).to eq('/dashboard')
    end
  end

  describe 'User Story #4 - Logging In Sad Path' do
    # As a registered user
    # When I visit the landing page `/`
    # And click on the link to go to my dashboard
    # And fail to fill in my correct credentials
    # I'm taken back to the Log In page
    # And I can see a flash message telling me that I entered incorrect credentials.
    it 'will return an error message if incorrect credentials are entered' do
      User.create!(name: 'Christopher Lee', email: 'dracula@hammer.com', password: 'test123')
      visit '/login'

      fill_in(:email, with: 'dracula@hammer.com')
      fill_in(:password, with: 'Test123')
      click_button('Submit')

      expect(current_path).to eq('/login')
      expect(page).to have_content('Invalid information. Please double check login info and try again.')

      fill_in(:email, with: 'dracula@hammer.edu')
      fill_in(:password, with: 'test123')
      click_button('Submit')

      expect(current_path).to eq('/login')
      expect(page).to have_content('Invalid information. Please double check login info and try again.')
    end
  end

  describe 'part 3 - log out on index page' do
    # As a logged in user
    # When I visit the landing page
    # I no longer see a link to Log In or Create an Account
    # But I see a link to Log Out.
    # When I click the link to Log Out
    # I'm taken to the landing page
    # And I can see that the Log Out link has changed back to a Log In link
    it 'can log out a user that is logged in' do
      User.create!(name: 'Christopher Lee', email: 'dracula@hammer.com', password: 'test123')
      visit '/'
      expect(page).to_not have_link('Log Out')
      expect(page).to have_link('Log In')
      expect(page).to have_button('Create a New User')

      click_link('Log In')

      expect(current_path).to eq('/login')

      fill_in(:email, with: 'dracula@hammer.com')
      fill_in(:password, with: 'test123')
      click_button('Submit')

      expect(current_path).to eq('/dashboard')

      visit '/'

      expect(page).to have_link('Log Out')
      expect(page).to_not have_link('Log In')
      expect(page).to_not have_button('Create a New User')

      click_link('Log Out')

      expect(current_path).to eq('/')
      expect(page).to_not have_link('Log Out')
      expect(page).to have_link('Log In')
      expect(page).to have_button('Create a New User')
    end
  end

  describe 'Authorization User Stories' do
    # User Story 1
    # As a visitor
    # When I visit the landing page
    # I do not see the section of the page that lists existing users
    # User Story 2
    # As a registered user
    # When I visit the landing page
    # The list of existing users is no longer a link to their show pages
    # But just a list of email addresses
    it '1. do not see emails if not logged in, 2. but have emails once logged in' do
      User.create!(name: 'Peter Cushing', email: 'helsing@hammer.com', password: 'test123')
      User.create!(name: 'Christopher Lee', email: 'dracula@hammer.com', password: 'test123')
      User.create!(name: 'Bela Lugosi', email: 'dracula@universal.com', password: 'test123')
      visit '/'
      expect(page).to_not have_content('helsing@hammer.com')
      expect(page).to_not have_content('dracula@hammer.com')
      expect(page).to_not have_content('dracula@universal.com')

      click_link('Log In')

      expect(current_path).to eq('/login')

      fill_in(:email, with: 'dracula@hammer.com')
      fill_in(:password, with: 'test123')
      click_button('Submit')

      expect(current_path).to eq('/dashboard')

      visit '/'

      expect(page).to have_content('helsing@hammer.com')
      expect(page).to have_content('dracula@hammer.com')
      expect(page).to have_content('dracula@universal.com')
      expect(page).to_not have_link('helsing@hammer.com')
      expect(page).to_not have_link('dracula@hammer.com')
      expect(page).to_not have_link('dracula@universal.com')
    end

    # User Story 3
    # As a visitor
    # When I visit the landing page
    # And then try to visit '/dashboard'
    # I remain on the landing page
    # And I see a message telling me that I must be logged in or registered to access my dashboard
    it 'returns an error if you try to visit the dashboard without being logged in' do
      visit '/'
      expect(page).to_not have_content('You must be logged in or registered to access your dashboard')

      visit '/dashboard'

      expect(current_path).to eq('/')
      expect(page).to have_content('You must be logged in or registered to access your dashboard')
    end
  end
end
