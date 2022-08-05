class Post < ApplicationRecord
  has_many_attached :images
  # has_one_attached :image
  belongs_to :user
  has_many :comments
  validates :user_id, presence:true
  validates :caption,presence:true,length:{maximum:140}
  # validates :image, content_type: { in: %w[image/jpeg image/gif image/png],message: "must be a valid image format" }, size: { less_than: 15.megabytes,message: "should be less than 15MB" }

end
