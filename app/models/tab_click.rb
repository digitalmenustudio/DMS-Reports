class TabClick < ApplicationRecord
    belongs_to :restaurant
  
    validates :restaurant_id, :tab_name, presence: true
    validates :tab_name, uniqueness: { scope: :restaurant_id, message: "Tab already exists for this restaurant" }
    validates :clicks, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  end
  