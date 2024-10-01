class Restaurant < ApplicationRecord

    searchable :name

    has_many :users, dependent: :destroy
    has_many :daily_visits, dependent: :destroy
    has_many :menu_access_logs, dependent: :destroy


    validates :launch_date, :name, presence: true
end
