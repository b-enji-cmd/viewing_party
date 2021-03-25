class UserParty < ApplicationRecord
  belongs_to :user
  belongs_to :party

  enum status: %w(invited host)
end
