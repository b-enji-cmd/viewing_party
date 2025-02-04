require 'rails_helper'

RSpec.describe User, type: :model do
  describe "relationships" do
    it { should have_many :user_parties }
    it { should have_many(:parties).through(:user_parties) }
    it { should have_many :friends }
  end

  describe "validations" do
    it { should validate_presence_of :email}
    it { should validate_uniqueness_of :email}
    it { should validate_presence_of :password}
  end

  describe "validations" do
    it {should validate_presence_of :email}
    it {should validate_presence_of :password}
    it {should validate_length_of(:password).is_at_least(8)}
    it {should validate_confirmation_of :password}
  end

  describe "instance methods" do
    it "#friends_email" do
      @user = User.create!(email: "winner@email.fr", password: "hellomovies2021")
      @user_1 = User.create!(email: "loser@email.fr", password: "superduper")
      UserFriend.create!(user_id: @user.id, friend_id: @user_1.id)

      expect(@user.friends_email).to eq ["loser@email.fr"]
    end
  end
end
