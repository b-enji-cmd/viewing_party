class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      redirect_to dashboard_path(@user)
    else
      flash[:error] = @user.errors.full_messages.to_sentance
      render :new
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
