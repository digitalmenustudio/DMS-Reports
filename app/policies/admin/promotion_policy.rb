module Admin
  class PromotionPolicy < ApplicationPolicy
    include AdminRestaurantScopedPolicy

    def permitted_attributes
      %i[name view_count]
    end
  end
end
