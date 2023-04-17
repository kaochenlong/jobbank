# frozen_string_literal: true

class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def edit
    @user = current_user
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to root_path, notice: '註冊成功'
    else
      render :new
    end
  end

  def update
    @user = current_user

    if @user.update(user_params)
      redirect_to edit_users_path, notice: 'ok'
    else
      render :edit
    end
  end

  def sign_in
    @user = User.new
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :birthday, :gender, :avatar, :remove_avatar)
  end
end
