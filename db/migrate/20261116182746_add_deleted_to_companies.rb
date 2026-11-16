class AddDeletedToCompanies < ActiveRecord::Migration[8.1]
  def change
    add_column :companies, :deleted, :boolean, default: false
  end
end
