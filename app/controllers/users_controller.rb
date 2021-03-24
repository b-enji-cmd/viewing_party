class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def create
    @user = User.create(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to dashboard_path
    else
      flash[:error] = @user.errors.full_messages.to_sentence
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
