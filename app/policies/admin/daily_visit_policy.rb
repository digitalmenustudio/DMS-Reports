module Admin
    class DailyVisitPolicy < ApplicationPolicy
      include AdminBasePolicy

      def index?
        user.restaurant_id.present? && user.admin?
      end
  
      def show?
        user.restaurant_id == record.restaurant_id && user.admin?
      end
  
      def create?
        user.restaurant_id.present? && user.admin?
      end
  
      def update?
        user.restaurant_id == record.restaurant_id && user.admin?
      end
  
      def edit?
        update? # same logic as update
      end
  
      def permitted_attributes
        %i[first_time_visitors recurring_visitors average_time_spent date weekday]
      end
    end
  end
  