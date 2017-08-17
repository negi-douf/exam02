class Picture < ActiveRecord::Base
  validates :image, presence: true
  validates :description, length: { maximum: 140 }

  mount_uploader :image, ImageUploader

  belongs_to :user
end
