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

      expect(page).to_not have_content("Name can't be blank")

      # fill_in(:name, with: "")
      fill_in(:email, with: 'not-frankenstein@gmail.com')
      click_button('Create New User')

      expect(current_path).to eq('/register')
      expect(page).to have_content("Name can't be blank")
    end

    it 'will return an error if email is missing' do
      visit '/register'

      expect(page).to_not have_content("Email can't be blank")

      fill_in(:name, with: "Frankenstein's Monster")
      # fill_in(:email, with: "")
      click_button('Create New User')

      expect(current_path).to eq('/register')
      expect(page).to have_content("Email can't be blank")
    end

    it 'will return an error if email is not unique' do
      User.create!(name: 'Adam Frankenstein', email: 'not-frankenstein@gmail.com', password: 'Test123', password_confirmation: 'Test123')
      visit '/register'

      expect(page).to_not have_content("Name can't be blank")

      fill_in(:name, with: "Frankenstein's Monster")
      fill_in(:email, with: 'not-frankenstein@gmail.com')
      fill_in(:password, with: 'test123')
      fill_in(:password_confirmation, with: 'test123')
      click_button('Create New User')

      expect(current_path).to eq('/register')
      expect(page).to have_content("Email has already been taken")
    end
  end

  describe 'Authentication sad path returns an error when' do
    it 'required fields are missing' do
      visit '/register'

      fill_in(:name, with: 'Christopher Lee')
      fill_in(:email, with: '')
      fill_in(:password, with: 'test123')
      fill_in(:password_confirmation, with: 'test123')
      click_button('Create New User')

      shouldnt_exist = User.where(name: 'Christopher Lee')

      expect(shouldnt_exist).to eq([])
      expect(current_path).to eq('/register')
      expect(page).to have_content("Email can't be blank")
    end

    it 'email is taken' do
      User.create!(name: 'Christopher Lee', email: 'dracula@hammer.com', password: 'test123')
      visit '/register'

      fill_in(:name, with: 'Peter Cushing')
      fill_in(:email, with: 'dracula@hammer.com')
      fill_in(:password, with: 'test123')
      fill_in(:password_confirmation, with: 'test123')
      click_button('Create New User')

      shouldnt_exist = User.where(name: 'Peter Cushing')

      expect(shouldnt_exist).to eq([])
      expect(current_path).to eq('/register')
      expect(page).to have_content('Email has already been taken')
    end

    it 'passwords do not match' do
      visit '/register'

      fill_in(:name, with: 'Christopher Lee')
      fill_in(:email, with: 'dracula@hammer.com')
      fill_in(:password, with: 'test123')
      fill_in(:password_confirmation, with: 'test321')
      click_button('Create New User')

      shouldnt_exist = User.where(name: 'Christopher Lee')

      expect(shouldnt_exist).to eq([])
      expect(current_path).to eq('/register')
      expect(page).to have_content("Password confirmation doesn't match Password")
    end

    it 'either password or password_confirmation is missing' do
      visit '/register'

      fill_in(:name, with: 'Christopher Lee')
      fill_in(:email, with: 'dracula@hammer.com')
      fill_in(:password, with: '')
      fill_in(:password_confirmation, with: 'test321')
      click_button('Create New User')

      shouldnt_exist = User.where(name: 'Christopher Lee')

      expect(shouldnt_exist).to eq([])
      expect(current_path).to eq('/register')
      expect(page).to have_content("Password digest can't be blank")
    end
  end
end
