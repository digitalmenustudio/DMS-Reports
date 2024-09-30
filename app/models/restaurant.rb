class Restaurant < ApplicationRecord

    searchable :name

    has_many :users, dependent: :destroy

    validates :launch_date, :name, presence: true
end
