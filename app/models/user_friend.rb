class UserFriend < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  def get_email
    User.find(friend.id).email
  end
end
