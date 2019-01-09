class AddBirthToAddresses < ActiveRecord::Migration[5.1]
  def change
    add_column :addresses, :birth_year, :integer
    add_column :addresses, :birth_month, :integer
    add_column :addresses, :birth_day, :integer
  end
end
