class User < ApplicationRecord
  has_secure_password

  validates :username, uniqueness: true
  validates :email, uniqueness: true

  has_many :entries
  has_many :comments
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id"
  has_many :following, through: :relationships, source: :followed
end
