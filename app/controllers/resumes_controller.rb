# frozen_string_literal: true

class ResumesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_resume, only: %i[like show edit update destroy]

  def index
    @resumes = if current_user.user?
                 current_user.resumes.order(created_at: :desc)
               else
                 Resume.order(created_at: :desc)
               end

    @resumes = @resumes.page(params[:page]).per(2)
    @resumes = @resumes.search(params[:keyword]) if params[:keyword].present?
  end

  def show
    @comment = Comment.new
    @comments =
      @resume.comments.where(user: current_user).order(created_at: :desc)
  end

  def new
    @resume = Resume.new

    authorize @resume
  end

  def edit
    authorize @resume
  end

  def create
    @resume = current_user.resumes.new(resume_params)

    authorize @resume

    if @resume.save
      redirect_to resumes_path, notice: '新增履歷成功'
    else
      render :new
    end
  end

  def update
    authorize @resume

    if @resume.update(resume_params)
      redirect_to edit_resume_path(@resume), notice: '已更新成功'
    else
      render :edit
    end
  end

  def destroy
    authorize @resume

    @resume.destroy
    redirect_to resumes_path, notice: '已成功刪除'
  end

  def like
    authorize(@resume)

    liked = current_user.like?(@resume)

    if liked
      # 變不喜歡
      current_user.liked_resumes.destroy(@resume)
      render json: { id: params[:id], status: 'unlike' }
    else
      # 變喜歡
      current_user.liked_resumes << @resume
      render json: { id: params[:id], status: 'like' }
    end
  end

  private

  def resume_params
    params.require(:resume).permit(
      :name,
      :email,
      :tel,
      :skill,
      :intro,
      :city,
      :education,
      :experience,
      :portfolio
    )
  end

  def find_resume
    @resume = if current_user.role == 1
                current_user.resumes.find(params[:id])
              else
                Resume.find(params[:id])
              end
  end
end
