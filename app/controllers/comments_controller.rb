class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_resume, only: [:create]
  before_action :find_comment, only: [:edit, :update, :destroy]

  def create
    @comment = @resume.comments.new(comment_params)

    if @comment.save
      redirect_to resume_path(@resume), notice: '新增評論成功'
    else
      @comments = @resume.comments.where(user: current_user).order(created_at: :desc)
      render 'resumes/show'
    end
  end

  def edit
  end

  def update
  end

  def destroy
    @comment.destroy
    redirect_to resume_path(@comment.resume), notice: '評論已刪除'
  end

  private

  def find_comment
    @comment = current_user.comments.find(params[:id])
  end

  def find_resume
    @resume = Resume.find(params[:resume_id])
  end

  def comment_params
    params.require(:comment).permit(:content).merge(user: current_user)
  end
end
