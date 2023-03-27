class ResumesController < ApplicationController
  def index
  end

  def new
    @resume = Resume.new
  end

  def create
    @resume = Resume.new(resume_params)

    if @resume.save
      # flash => kind of hash
      # flash[:notice] = "ok"
      redirect_to root_path, notice: 'ok'
    else
      render :new
    end
  end

  private

  def resume_params
    params.require(:resume).permit(:name, :email, :tel, :skill, :intro, :city, :education, :experience, :portfolio)
  end
end
