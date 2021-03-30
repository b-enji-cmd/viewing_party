class Movie < ApplicationRecord
  has_many :parties, dependent: :destroy

  validates :title, uniqueness: true, presence: true
end
