# frozen_string_literal: true

class FavoriteResume < ApplicationRecord
  belongs_to :user
  belongs_to :resume
end
