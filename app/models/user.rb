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
  # validations
  validates :email,
            presence: true,
            uniqueness: true,
            format: {
              with: /\A[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}\z/
            }
  validates :password, presence: true, confirmation: true
  validates :birthday, presence: true

  # callbacks
  before_create :encrypt_password

  # relationships
  has_many :resumes

  # enum
  enum role: { user: 1, company: 2, staff: 3 }
  enum gender: { "不公開": 0, "男": 1, "女": 2, "其它": 3 }

  class << self
    def gender_list
      genders.map { |k, v| [k, k] }
    end

    def login(email:, password:)
      encrypted_password = Digest::SHA1.hexdigest("7a#{password}9x")
      find_by(email: email, password: encrypted_password)
    end
  end

  private

  def encrypt_password
    self.password = Digest::SHA1.hexdigest("7a#{self.password}9x")
  end
end
