class ResumesController < ApplicationController
  before_action :find_resume, only: [:show, :edit, :update, :destroy]

  def index
    @resumes = Resume.order(created_at: :desc)

    if params[:keyword].present?
      @resumes = @resumes.search(params[:keyword])
    end
  end

  def show
  end

  def edit
  end

  def update
    if @resume.update(resume_params)
      redirect_to edit_resume_path(@resume), notice: '已更新成功'
    else
      render :edit
    end
  end

  def new
    @resume = Resume.new
  end

  def create
    @resume = Resume.new(resume_params)

    if @resume.save
      redirect_to resumes_path, notice: '新增履歷成功'
    else
      render :new
    end
  end

  def destroy
    @resume.destroy
    redirect_to resumes_path, notice: '已成功刪除'
  end

  private

  def resume_params
    params.require(:resume).permit(:name, :email, :tel, :skill, :intro, :city, :education, :experience, :portfolio)
  end

  def find_resume
    @resume = Resume.find(params[:id])
  end
end
