# frozen_string_literal: true

module Api
  module V1
    class ResumesController < ApplicationController
      before_action :authenticate_user!
      before_action :find_resume

      def sort
        # 寫進資料庫
        @resume.insert_at(params[:newIndex].to_i)

        # position
        render json: { id: params[:id], result: 'ok' }
      end

      private

      def find_resume
        @resume = if current_user.role == 1
                    current_user.resumes.find(params[:id])
                  else
                    Resume.find(params[:id])
                  end
      end
    end
  end
end
