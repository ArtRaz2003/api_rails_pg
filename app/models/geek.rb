class Geek < ApplicationRecord
  has_many :applies

  validates :name, :stack, presence: true
end