class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :like_users, through: :likes, source: :user
  has_many_attached :post_pictures

  attribute :new_post_pictures

  validates :body,
    presence: true,
    length: { minimum: 1, maximum: 140, allow_blank: true}

  before_save do
    if new_post_pictures
      self.post_pictures = new_post_pictures
    end
  end
end
