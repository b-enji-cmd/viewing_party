class Movie < ApplicationRecord
  has_many :parties

  validates :title, uniqueness: true, presence: true
end
