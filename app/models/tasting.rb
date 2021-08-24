class Tasting < ApplicationRecord
  belongs_to :user
  has_many :participations, dependent: :destroy
  has_many :categories
  has_one_attached :photo
end
