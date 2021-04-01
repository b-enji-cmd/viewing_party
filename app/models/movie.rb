class Movie < ApplicationRecord
  has_many :parties

  validates :title, presence: true
end
