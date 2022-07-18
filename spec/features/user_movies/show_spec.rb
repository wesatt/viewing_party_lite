# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'The UserMovie Show Page' do
  describe 'has buttons', :vcr do
    it 'has a button to create a viewing party' do
      user = User.create!(name: 'Rand', email: 'randalthor@gmail.com', password: 'test123')
      movie = Movie.new(id: 550, title: 'Fight Club', vote_average: 8.4)
      visit "/users/#{user.id}/movies/#{movie.id}"

      click_button("Create Viewing Party for #{movie.title}")
      # expect(page).to have_button("Create Viewing Party for #{movie.title}")
      expect(current_path).to eq("/users/#{user.id}/movies/#{movie.id}/view_parties/new")
    end

    it 'has a button to return to the discover page' do
      user = User.create!(name: 'Rand', email: 'randalthor@gmail.com', password: 'test123')
      movie = Movie.new(id: 550, title: 'Fight Club', vote_average: 8.4)
      visit "/users/#{user.id}/movies/#{movie.id}"

      click_button('Discover Page')

      expect(current_path).to eq("/users/#{user.id}/discover")
    end
  end

  describe 'contains movie information', :vcr do
    before(:each) do
      @user = User.create!(name: 'Rand', email: 'randalthor@gmail.com', password: 'test123')
      @movie = Movie.new(id: 550, title: 'Fight Club', vote_average: 8.4)
      visit "/users/#{@user.id}/movies/#{@movie.id}"
    end

    it 'has the movie title' do
      expect(page).to have_content('Fight Club')
    end

    it 'contains the vote average for the movie' do
      expect(page).to have_content("Vote Average: #{@movie.vote_average}")
    end

    it 'has runtime in hours and minutes' do
      expect(page).to have_content('Runtime: 2hr 19 min')
    end

    it 'has the genres associated with the movies' do
      expect(page).to have_content('Genre(s): Drama')
    end

    it 'contains a summary description of the movie' do
      expect(page).to have_content('A ticking-time-bomb insomniac and a slippery soap salesman channel primal male aggression into a shocking new form of therapy. Their concept catches on, with underground "fight clubs" forming in every town, until an eccentric gets in the way and ignites an out-of-control spiral toward oblivion.')
    end

    it 'lists the first 10 cast members' do
      expect(page).to have_content('Edward Norton as The Narrator')
      expect(page).to_not have_content('Christina Cabot as Group Leader')
    end

    it 'has a count of total reviews' do
      expect(page).to have_content('7 Reviews')
    end

    it 'has each reviews author and information' do
      expect(page).to have_content('Author: Goddard')
      expect(page).to have_content('Pretty awesome movie. It shows what one crazy person can convince other crazy people to do. Everyone needs something to believe in. I recommend Jesus Christ, but they want Tyler Durden.')
    end
  end
end
