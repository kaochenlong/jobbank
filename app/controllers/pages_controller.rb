class PagesController < ApplicationController
  def about
  end

  def contact
  end

  def home
    flash[:notice] = 123
  end
end
