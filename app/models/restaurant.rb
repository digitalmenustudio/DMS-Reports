class Restaurant < ApplicationRecord

    searchable :email, :name

    validates :launch_date, :name, presence: true
end
