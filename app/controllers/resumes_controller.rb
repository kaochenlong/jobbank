class ResumesController < ApplicationController
  def index
  end

  def new
    @resume = Resume.new
  end

  def create
    @resume = Resume.new(resume_params)

    if @resume.save
      redirect_to root_path, notice: '新增履歷成功'
    else
      render :new
    end
  end

  private

  def resume_params
    params.require(:resume).permit(:name, :email, :tel, :skill, :intro, :city, :education, :experience, :portfolio)
  end
end
