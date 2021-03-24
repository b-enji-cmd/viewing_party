class User < ApplicationRecord
  has_many :user_parties
  has_many :parties, through: :user_parties
  has_many :friends, class_name: "UserFriend", foreign_key: "user_id"

  validates :email, uniqueness: true, presence: true
  validates :password, presence: true

  has_secure_password
end

