class Company < ApplicationRecord
  has_many :jobs
  validates :name, :location, presence: true

  def delete_company
    update(deleted: true)
  end
end