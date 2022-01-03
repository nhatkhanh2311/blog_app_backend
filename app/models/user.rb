class User < ApplicationRecord
  has_secure_password
  has_one_attached :avatar

  validates :username, uniqueness: true
  validates :email, uniqueness: true

  has_many :entries
  has_many :comments
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id"
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id"
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
end
