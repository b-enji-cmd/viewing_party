require 'rails_helper'

RSpec.describe Party, type: :model do
  describe "relationships" do
    it { should belong_to :user }
  end

  describe "validations" do
    it {should validate_presence_of :duration}
    it {should validate_presence_of :date}
    it {should validate_presence_of :start_time}
  end
end
