module Admin
  class UserPolicy < ApplicationPolicy
    include AdminBasePolicy

    def switch_restaurant?
      user.admin?
    end

    def permitted_attributes
      %i[first_name last_name role email restaurant_id password password_confirmation]
    end
  end
end
