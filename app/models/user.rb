class User < ApplicationRecord
  has_many :user_parties
  has_many :parties, through: :user_parties
  has_many :friends, class_name: 'UserFriend'

  validates :email, uniqueness: true, presence: true, format: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  validates :password, length: { minimum: 8 }, presence: true
  validates :password, confirmation: true

  has_secure_password

  def friends_email
    friends.map do |friend|
      User.find(friend.friend_id).email
    end
  end
end
