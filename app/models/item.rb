class Item < ApplicationRecord
    belongs_to :restaurant
  
    validates :name, :item_type, presence: true
    validates :name, uniqueness: { scope: [:restaurant_id, :item_type], message: "Item already exists for this restaurant and type" }
    validates :clicks, :likes, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  end
  