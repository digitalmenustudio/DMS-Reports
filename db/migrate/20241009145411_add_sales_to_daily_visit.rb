class AddSalesToDailyVisit < ActiveRecord::Migration[7.0]
  def change
    change_table :daily_visits, bulk: true do |t|
      t.remove :average_time_spent
      t.integer :minutes, default: 0, null: false
      t.integer :seconds, default: 0, null: false
      t.float :sales
    end
  end
end
