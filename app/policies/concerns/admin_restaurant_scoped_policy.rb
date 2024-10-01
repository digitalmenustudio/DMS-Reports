# This concern handles policies for models that are scoped to a specific restaurant
module AdminRestaurantScopedPolicy
    extend ActiveSupport::Concern
  
    included do |klass|
      # Scope for admin users scoped to the user's restaurant
      class klass::Scope < klass::Scope
        def resolve
          if user.admin? && user.restaurant_id.present?
            scope.where(restaurant_id: user.restaurant_id)
          else
            scope.none
          end
        end
      end
  
      def index?
        user.admin? && user.restaurant_id.present?
      end
  
      def show?
        user.admin? && user.restaurant_id == record.restaurant_id
      end
  
      def create?
        user.admin? && user.restaurant_id.present?
      end
  
      def update?
        user.admin? && user.restaurant_id == record.restaurant_id
      end
  
      def edit?
        update?
      end
  
      def destroy?
        user.admin? && user.restaurant_id == record.restaurant_id
      end
    end
  end
  