module Admin
    class TabClickPolicy < ApplicationPolicy
      include AdminRestaurantScopedPolicy
  
      # Define which attributes are permitted for mass assignment
      def permitted_attributes
        %i[tab_name clicks]
      end
    end
  end
  