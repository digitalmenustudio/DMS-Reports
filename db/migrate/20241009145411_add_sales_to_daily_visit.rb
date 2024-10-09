class AddSalesToDailyVisit < ActiveRecord::Migration[7.0]
  def change
    change_table :daily_visits, bulk: true do |t|
      t.float :sales
    end
  end
end
