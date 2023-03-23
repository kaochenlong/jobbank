class ResumesController < ApplicationController

  def index
  end

  def new
  end

  def create
    # 寫入資料庫
    redirect_to root_path
  end
end
