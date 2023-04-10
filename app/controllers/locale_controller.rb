# frozen_string_literal: true

class LocaleController < ApplicationController
  def change
    lang = params[:lang]

    if available_locale.include?(lang)
      # 切語系
      session[:locale] = lang
      redirect_to root_path
    else
      record_not_found
    end
  end

  private

  def available_locale
    %w[zh_tw ja]
  end
end
