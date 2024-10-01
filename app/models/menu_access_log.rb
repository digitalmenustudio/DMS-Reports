class MenuAccessLog < ApplicationRecord
    belongs_to :restaurant
  
    validates :restaurant_id, :day_of_week, :time_frame, presence: true
    validates :visitors, numericality: { greater_than_or_equal_to: 0 }
    validates :day_of_week, uniqueness: { scope: [:restaurant_id, :time_frame], message: "Already exists for this restaurant and time frame" }
  end
  