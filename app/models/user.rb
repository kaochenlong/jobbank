# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  email      :string
#  password   :string
#  nickname   :string
#  birthday   :date
#  role       :integer          default(1)
#  gender     :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ApplicationRecord
  validates :email, presence: true,
                    uniqueness: true,
                    format: {
                      with: /\A[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}\z/
                    }
  validates :password, presence: true, confirmation: true
  validates :birthday, presence: true

  def self.gender_list
    [ ['不公開', 0], ['男', 1], ['女', 2], ['其它', 3] ]
  end
end
