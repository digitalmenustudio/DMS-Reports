class Promotion < ApplicationRecord
  belongs_to :restaurant

  validates :name, presence: true
  validates :name, uniqueness: { scope: :restaurant_id, message: "Promotion already exists for this restaurant" }
  validates :view_count, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
