class UserParty < ApplicationRecord
  belongs_to :user
  belongs_to :party

  enum status: { 'invited' => 0, 'host' => 1 }
end
