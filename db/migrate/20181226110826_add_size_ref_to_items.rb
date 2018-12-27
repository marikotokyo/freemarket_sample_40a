class AddSizeRefToItems < ActiveRecord::Migration[5.1]
  def change
    add_reference :items, :size, foreign_key: true
  end
end
