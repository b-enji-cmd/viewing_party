class UserFriendsController < ApplicationController
  def create
    friend = User.find_by(email: params[:email])
    user = current_user.id
    if friend
      UserFriend.create!(user_id: user, friend_id: friend.id)
    else
      flash[:error] = 'That user does not exist'
    end
    redirect_to dashboard_path
  end
end
