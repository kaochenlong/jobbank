class Resume < ApplicationRecord
  validates :name, :tel, presence: true
  validates :email, presence: true, format: { with: /\A[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}\z/}

  def self.search(keyword)
    where("intro like ?", "%#{keyword}%")
  end
end
