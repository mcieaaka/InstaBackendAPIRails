class User < ApplicationRecord
    has_one_attached :image

    before_save { email.downcase! }
    validates(:name, presence: true, length: { maximum: 50 })
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: {case_sensitive:false}
    validates :bio, presence: true, length: {maximum:140}
    validates :image, content_type: { in: %w[image/jpeg image/gif image/png],message: "must be a valid image format" }, size: { less_than: 15.megabytes,message: "should be less than 15MB" }

    def display_image
        image.variant(resize_to_limit: [500, 500])
    end
end
