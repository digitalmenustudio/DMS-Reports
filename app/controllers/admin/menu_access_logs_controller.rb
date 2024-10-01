module Admin
    class MenuAccessLogsController < ApplicationController
      before_action :set_restaurant
      before_action :set_menu_access_log, only: %i[edit update show destroy]
      before_action -> { authorize @menu_access_log || MenuAccessLog }
  
      decorates_assigned :menu_access_log, :menu_access_logs
      add_controller_helpers :menu_access_logs, only: :index
  
      def index
        @menu_access_logs = policy_scope(MenuAccessLog).where(restaurant: @restaurant).order(day_of_week: :asc, time_frame: :asc)
      end
  
      def show
      end
  
      def new
        @menu_access_log = @restaurant.menu_access_logs.new
      end
  
      def edit
      end
  
      def create
        @menu_access_log = @restaurant.menu_access_logs.new(menu_access_log_params)
  
        if @menu_access_log.save
          redirect_to admin_menu_access_logs_path, notice: create_successful_notice
        else
          render :new, status: :unprocessable_entity
        end
      end
  
      def update
        @menu_access_log.assign_attributes(menu_access_log_params)
  
        if @menu_access_log.save
          redirect_to admin_menu_access_logs_path, notice: update_successful_notice
        else
          render :edit, status: :unprocessable_entity
        end
      end
  
      def destroy
        @item.destroy
        redirect_to admin_items_path, notice: destroy_successful_notice
      end

      private
  
      # Load the restaurant based on the current user
      def set_restaurant
        @restaurant = Restaurant.find(current_user.restaurant_id)
      end
  
      # Find the specific menu access log by day and time frame
      def set_menu_access_log
        @menu_access_log = policy_scope(@restaurant.menu_access_logs).find(params[:id])
      end
  
      # Strong parameters to allow only permitted attributes
      def menu_access_log_params
        params.require(:menu_access_log).permit(:day_of_week, :time_frame, :visitors)
      end
    end
  end
  