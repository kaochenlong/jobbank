# == Schema Information
#
# Table name: resumes
#
#  id         :integer          not null, primary key
#  name       :string
#  email      :string
#  tel        :string
#  skill      :string
#  intro      :text
#  city       :string
#  education  :text
#  experience :text
#  portfolio  :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  deleted_at :datetime
#  user_id    :integer
#
class Resume < ApplicationRecord
  acts_as_paranoid

  validates :name, :tel, presence: true
  validates :email,
            presence: true,
            format: {
              with: /\A[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}\z/
            }

  # relationships
  belongs_to :user
  has_many :comments

  has_many :favorite_resumes
  has_many :users, through: :favorite_resumes

  def self.search(keyword)
    where("intro like ?", "%#{keyword}%")
  end
end
