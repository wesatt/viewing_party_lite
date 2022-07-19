# frozen_string_literal: true

class ViewPartiesController < ApplicationController
  def new
    @movie = MovieFacade.find_movie(params[:movie_id])
    @users = User.all
  end

  def create
    host = current_user
    if params[:movie_runtime].to_i <= params[:duration].to_i
      party = ViewParty.new(
        movie_api_id: params[:movie_id],
        duration: params[:duration],
        date: params[:date],
        time: params[:time],
        movie_image_path: params[:movie_image_path],
        movie_title: params[:movie_title],
        host_id: session[:user_id]
      )
      if party.save
        UserViewParty.create!(
          user_id: host.id,
          view_party_id: party.id,
          host: true
        )
        if params[:invited].present?
          params[:invited].each do |invited_id|
            UserViewParty.create!(
              user_id: invited_id.to_i,
              view_party_id: party.id,
              host: false
            )
          end
        end
        redirect_to '/dashboard'
      else
        redirect_to "/movies/#{params[:movie_id]}/view_parties/new",
                    notice: 'Invalid Data. Please keep data in the displayed format.'
      end
    else
      redirect_to "/movies/#{params[:movie_id]}/view_parties/new",
                  notice: 'Duration of party cannot be less than movie runtime.'
    end
  end
end
