class User < ApplicationRecord
  has_secure_password

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post
  has_many :following_relationships, foreign_key: "follower_id", class_name: "Relationship", dependent: :destroy
  has_many :followings, through: :following_relationships
  has_many :follower_relationships, foreign_key: "following_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :follower_relationships
  has_one_attached :profile_picture
  attribute :new_profile_picture
  attribute :remove_profile_picture, :boolean

  validates :name, presence: true,
    format: { with: /\A[A-Za-z][A-Za-z0-9]*\z/, allow_blank: true},
    length: { minimum: 2, maximum: 20, allow_blank: true},
    uniqueness: { case_sensitive: false}
  validates :email, presence: true, email: { allow_blank: true}

  attr_accessor :current_password
  validates :password, presence: { if: :current_password }

  validate if: :new_profile_picture do
    if new_profile_picture.respond_to?(:content_type)
      unless new_profile_picture.content_type.in?(ALLOWED_CONTENT_TYPES)
        errors.add(:new_profile_picture, :invalid_image_type)
      end
    else
      errors.add(:new_profile_picture, :invalid)
    end
  end

  before_save do
    if new_profile_picture
      self.profile_picture = new_profile_picture
    elsif remove_profile_picture
      self.profile_picture.purge
    end
  end

  def likable_for?(post)
    post && post.user != self && !likes.exists?(post_id: post.id)
  end

  def unlikable_for?(post)
    post && post.user != self && likes.exists?(post_id: post.id)
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end

  def follow(other_user)
    self.following_relationships.create(following_id: other_user.id)
  end

  def unfollow(other_user)
    self.following_relationships.find_by(following_id: other_user.id).destroy
  end

  def self.guest
    find_or_create_by!(name: 'guest') do |user|
      user.assign_attributes({
      email: "guest@example.com",
      birthday: "1990-01-01",
      sex: 3})
      user.password = SecureRandom.urlsafe_base64
    end
  end

  class << self
    def search(query)
      rel = order("id")
      if query.present?
        rel = rel.where("name LIKE ?", "%#{query}%")
      end
      rel
    end
  end
end
