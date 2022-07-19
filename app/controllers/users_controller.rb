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
      redirect_to '/register', notice: new_user.errors.full_messages.first
    end
  end

  def login_form
    render 'login_form'
  end

  def login_user
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      redirect_to "/users/#{user.id}"
    else
      redirect_to '/login', notice: 'Invalid information. Please double check login info and try again.'
    end
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
