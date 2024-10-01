class CreatePromotions < ActiveRecord::Migration[7.0]
  def change
    create_table :promotions do |t|
      t.references :restaurant, null: false, foreign_key: true, index: true # Associate with restaurant
      t.string :name, null: false # Name of the promotion
      t.integer :view_count, default: 0, null: false # Number of views for this promotion

      t.timestamps
    end
  end
end
