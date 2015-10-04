class Comment < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  mount_uploader :image, ImageUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validate :image_size
  
  private
  
    # Validates the size of an uploaded image
    def image_size
      if image.size > 5.megabytes
        errors.add(:image, "image should be less than 5MB")
      end
    end
end
