module Admin
    class DailyVisitPolicy < ApplicationPolicy
      include AdminRestaurantScopedPolicy
  
      def permitted_attributes
        %i[first_time_visitors recurring_visitors minutes seconds date weekday sales]
      end
    end
  end
  