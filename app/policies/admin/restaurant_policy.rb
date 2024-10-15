module Admin
  class RestaurantPolicy < ApplicationPolicy
    include AdminBasePolicy

    def upload_data?
      user.admin? && user.restaurant_id == record.id
    end

    def permitted_attributes
      %i[name launch_date]
    end
  end
end
