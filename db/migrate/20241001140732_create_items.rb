class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.references :restaurant, null: false, foreign_key: true, index: true # Associate with restaurant
      t.string :name, null: false # Name of the item (either cocktail or food)
      t.string :item_type, null: false # Item type: cocktail or food
      t.integer :clicks, default: 0, null: false # Number of clicks on the item
      t.integer :likes, default: 0, null: false # Number of likes on the item

      t.timestamps
    end

    add_index :items, [:restaurant_id, :name, :item_type], unique: true
  end
end
