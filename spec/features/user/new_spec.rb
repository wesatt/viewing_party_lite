# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Registration Page', type: :feature do
  describe 'New User View' do
    it 'has a form that can create a new user' do
      visit '/register'

      new_user = User.where(name: "Frankenstein's Monster")

      expect(new_user).to eq([])

      fill_in(:name, with: "Frankenstein's Monster")
      fill_in(:email, with: 'not-frankenstein@gmail.com')
      fill_in(:password, with: 'test123')
      fill_in(:password_confirmation, with: 'test123')
      click_button('Create New User')

      new_user = User.where(name: "Frankenstein's Monster").first

      expect(current_path).to eq("/users/#{new_user.id}")
      # expect(page).to have_content("Frankenstein's Monster's Dashboard")
    end

    it 'will return an error if name is missing' do
      visit '/register'

      expect(page).to_not have_content('A required field was missing or email is already in use')

      # fill_in(:name, with: "")
      fill_in(:email, with: 'not-frankenstein@gmail.com')
      click_button('Create New User')

      expect(current_path).to eq('/register')
      expect(page).to have_content('A required field was missing or email is already in use')
    end

    it 'will return an error if email is missing' do
      visit '/register'

      expect(page).to_not have_content('A required field was missing or email is already in use')

      fill_in(:name, with: "Frankenstein's Monster")
      # fill_in(:email, with: "")
      click_button('Create New User')

      expect(current_path).to eq('/register')
      expect(page).to have_content('A required field was missing or email is already in use')
    end

    it 'will return an error if email is not unique' do
      User.create(name: 'Adam Frankenstein', email: 'not-frankenstein@gmail.com')
      visit '/register'

      expect(page).to_not have_content('A required field was missing or email is already in use')

      fill_in(:name, with: "Frankenstein's Monster")
      fill_in(:email, with: 'not-frankenstein@gmail.com')
      click_button('Create New User')

      expect(current_path).to eq('/register')
      expect(page).to have_content('A required field was missing or email is already in use')
    end
  end
end
