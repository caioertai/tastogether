class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  has_many :participations
  has_many :tastings, through: :participations

  has_many :hosting_participations, -> { where(host: true, status: "accepted") }, class_name: "Participation"
  has_many :hosted_tastings, through: :hosting_participations, source: :tasting

  validates :email, :address, presence: true
  validates :email, :username, uniqueness: true
  validates :bio, length: { maximum: 250 }
end
