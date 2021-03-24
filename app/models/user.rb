class User < ApplicationRecord
  has_many :user_parties
  has_many :parties, through: :user_parties
  has_many :friends, class_name: "UserFriend", foreign_key: "user_id"

  validates :email, uniqueness: true, presence: true, format: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  validates :password, length: { minimum: 8 }, presence: true, confirmation: true
  # validates :password_confirmation, presence: { message: "failed, passwords must match. Please try again." }

  has_secure_password
end
