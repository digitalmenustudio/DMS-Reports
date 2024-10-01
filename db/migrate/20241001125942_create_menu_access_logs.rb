class CreateMenuAccessLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :menu_access_logs do |t|
      t.references :restaurant, null: false, foreign_key: true, index: true
      t.string :day_of_week, null: false # 'Monday', 'Tuesday', etc.
      t.string :time_frame, null: false  # e.g., '00:00-03:00', '16:00-16:30', etc.
      t.integer :visitors, default: 0, null: false

      t.timestamps
    end

    # Add a unique index with a shorter name
    add_index :menu_access_logs, [:restaurant_id, :day_of_week, :time_frame], unique: true, name: 'index_logs_on_restaurant_day_time'
  end
end
