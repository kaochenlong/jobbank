# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization

  before_action :set_locale

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  helper_method :user_signed_in?, :current_user

  private

  def set_locale
    locale = session[:locale] || I18n.default_locale
    I18n.locale = locale
  end

  def user_signed_in?
    session[:_user_resume_dev_].present?
  end

  def current_user
    return @__user__ ||= User.find_by(id: session[:_user_resume_dev_]) if user_signed_in?

    nil
  end

  def authenticate_user!
    redirect_to sign_in_users_path unless user_signed_in?
  end

  def record_not_found
    render file: Rails.public_path.join('404.html'),
           layout: false,
           status: :not_found and return
  end

  def user_not_authorized
    flash[:alert] = '權限不足'
    redirect_back(fallback_location: root_path)
  end
end
