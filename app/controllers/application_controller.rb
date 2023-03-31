class ApplicationController < ActionController::Base
  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  helper_method :user_signed_in?, :current_user

  private

  def user_signed_in?
    session[:_user_resume_dev_].present?
  end

  def current_user
    if user_signed_in?
      return @__user__ ||= User.find_by(id: session[:_user_resume_dev_])
    end

    return nil
  end

  def authenticate_user!
    redirect_to sign_in_users_path if not user_signed_in?
  end

  def record_not_found
    render file: Rails.root.join("public", "404.html"),
           layout: false,
           status: 404 and return
  end

  def user_not_authorized
    flash[:alert] = "權限不足"
    redirect_back(fallback_location: root_path)
  end
end
