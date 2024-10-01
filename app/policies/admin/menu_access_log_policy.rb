module Admin
    class MenuAccessLogPolicy < ApplicationPolicy
      include AdminRestaurantScopedPolicy
  
      def permitted_attributes
        %i[day_of_week time_frame visitors]
      end
    end
  end
  