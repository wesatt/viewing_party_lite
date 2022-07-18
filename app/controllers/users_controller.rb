# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new; end

  def show
    @user = User.find(params[:id])
  end

  def discover
    @user = User.find(params[:id])
  end

  def create
    new_user = User.new(user_params)
    if new_user.save
      redirect_to "/users/#{new_user.id}"
    else
      redirect_to '/register', notice: 'A required field was missing or email is already in use'
    end
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
