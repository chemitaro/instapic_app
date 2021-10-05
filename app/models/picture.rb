class Picture < ApplicationRecord
  mount_uploader :content_picture, ContentPictureUploader
  belongs_to :user
  validates :title, presence: true
  validates :content, presence: true
  validates :content_picture, presence: true
end
