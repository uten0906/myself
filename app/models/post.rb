class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :like_users, through: :likes, source: :user
  has_many_attached :post_pictures

  attribute :new_post_pictures
  attribute :remove_post_pictures

  validates :body,
    presence: true,
    length: { minimum: 1, maximum: 140, allow_blank: true}

  validate if: :new_post_pictures do
    if new_post_pictures.map {|p| p.respond_to?(:content_type)}
      unless new_post_pictures.map {|p| p.content_type.in?(ALLOWED_CONTENT_TYPES)}
        errors.add(:new_post_pictures, :invalid_image_type)
      end
    else
      errors.add(:new_post_pictures, :invalid)
    end
  end

  before_save do
    if new_post_pictures
      self.post_pictures = new_post_pictures
    end
  end
end
