# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2024_10_01_125942) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_trgm"
  enable_extension "plpgsql"
  enable_extension "unaccent"

  create_table "daily_visits", force: :cascade do |t|
    t.bigint "restaurant_id", null: false
    t.date "date", null: false
    t.string "weekday", null: false
    t.integer "first_time_visitors", default: 0, null: false
    t.integer "recurring_visitors", default: 0, null: false
    t.decimal "average_time_spent", precision: 5, scale: 2, default: "0.0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["date"], name: "index_daily_visits_on_date"
    t.index ["restaurant_id"], name: "index_daily_visits_on_restaurant_id"
  end

  create_table "menu_access_logs", force: :cascade do |t|
    t.bigint "restaurant_id", null: false
    t.string "day_of_week", null: false
    t.string "time_frame", null: false
    t.integer "visitors", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["restaurant_id", "day_of_week", "time_frame"], name: "index_logs_on_restaurant_day_time", unique: true
    t.index ["restaurant_id"], name: "index_menu_access_logs_on_restaurant_id"
  end

  create_table "restaurants", force: :cascade do |t|
    t.string "name"
    t.date "launch_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "role"
    t.string "first_name"
    t.string "last_name"
    t.bigint "restaurant_id", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["restaurant_id"], name: "index_users_on_restaurant_id"
  end

  add_foreign_key "daily_visits", "restaurants"
  add_foreign_key "menu_access_logs", "restaurants"
  add_foreign_key "users", "restaurants"
end
