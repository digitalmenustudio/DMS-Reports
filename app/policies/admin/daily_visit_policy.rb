module Admin
    class DailyVisitPolicy < ApplicationPolicy
      include AdminRestaurantScopedPolicy
  
      def permitted_attributes
        %i[first_time_visitors recurring_visitors average_time_spent date weekday]
      end
    end
  end
  