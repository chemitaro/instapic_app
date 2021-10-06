class Picture < ApplicationRecord
  mount_uploader :content_picture, ContentPictureUploader
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user
  validates :title, presence: true
  validates :content, presence: true
  validates :content_picture, presence: true
end
