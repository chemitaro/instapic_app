class Picture < ApplicationRecord
  mount_uploader :content_picture, ContentPictureUploader
  belongs_to :user
end
