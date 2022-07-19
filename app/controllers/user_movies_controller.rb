# frozen_string_literal: true

class UserMoviesController < ApplicationController
  def index
    case params[:q]
    when 'top 20rated'
      @movies = MovieFacade.top_40
    when ''
      redirect_to "/discover", notice: 'Search cannot be blank.'
    else
      @search_movies = MovieFacade.search_by_keyword(params[:q])
    end
  end

  def show
    @movie = MovieFacade.find_movie(params[:id])
    @cast = MovieFacade.find_cast(params[:id])
    @review = MovieFacade.find_review(params[:id])
  end
end
