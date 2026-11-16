class Job < ApplicationRecord
  belongs_to :company
  has_many :applies

  validates :name, :place, :company_id, presence: true
  validates :company_id, numericality: { only_integer: true }
end