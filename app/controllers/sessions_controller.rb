# frozen_string_literal: true

class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to "/dashboard"
    else
      redirect_to '/login', notice: 'Invalid information. Please double check login info and try again.'
    end
  end
end
