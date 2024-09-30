class AddFieldRestaurantToUser < ActiveRecord::Migration[7.0]
  def change
    change_table :users, bulk: true do |t|
      t.references :restaurant, null: false, foreign_key: true
    end
  end
end
