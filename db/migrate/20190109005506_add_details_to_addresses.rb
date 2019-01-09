class AddDetailsToAddresses < ActiveRecord::Migration[5.1]
  def change
    add_column :addresses, :family_name, :string
    add_column :addresses, :first_name, :string
    add_column :addresses, :family_name_kana, :string
    add_column :addresses, :first_name_kana, :string
  end
end
