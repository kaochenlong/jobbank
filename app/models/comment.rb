# frozen_string_literal: true

# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  content    :text
#  deleted_at :datetime
#  user_id    :integer          not null
#  resume_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Comment < ApplicationRecord
  acts_as_paranoid

  # validations
  validates :content, presence: true

  # relationships
  belongs_to :user
  belongs_to :resume
end
