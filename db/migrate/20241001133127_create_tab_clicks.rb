class CreateTabClicks < ActiveRecord::Migration[7.0]
  def change
    create_table :tab_clicks do |t|
      t.references :restaurant, null: false, foreign_key: true, index: true # Associate with restaurant
      t.string :tab_name, null: false # Name or identifier of the tab
      t.integer :clicks, default: 0, null: false # Number of clicks for the tab

      t.timestamps
    end

    # Add a unique index to ensure no duplicate records for the same restaurant and tab
    add_index :tab_clicks, [:restaurant_id, :tab_name], unique: true
  end
end
