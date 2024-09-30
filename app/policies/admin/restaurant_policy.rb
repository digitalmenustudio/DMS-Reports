module Admin
  class RestaurantPolicy < ApplicationPolicy
    include AdminBasePolicy

    def permitted_attributes
      %i[name launch_date]
    end
  end
end
