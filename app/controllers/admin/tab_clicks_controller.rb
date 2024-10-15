module Admin
    class TabClicksController < ApplicationController
      before_action :set_restaurant
      before_action :set_tab_click, only: [:show, :edit, :update, :destroy]
      before_action -> { authorize @tab_click || TabClick }

      decorates_assigned :tab_click, :tab_clicks
      add_controller_helpers :tab_clicks, only: :index
  
      # List all tab clicks for the restaurant
      def index
        @tab_clicks = policy_scope(TabClick).where(restaurant: @restaurant).order(clicks: :desc)
      end
  
      # Show a specific tab click record
      def show
      end
  
      # New tab click form
      def new
        @tab_click = @restaurant.tab_clicks.new
      end
  
      # Edit tab click form
      def edit
      end
  
      # Create a new tab click record
      def create
        @tab_click = @restaurant.tab_clicks.new(tab_click_params)
  
        if @tab_click.save
          redirect_to admin_tab_clicks_path, notice: create_successful_notice
        else
          render :new, status: :unprocessable_entity
        end
      end
  
      # Update an existing tab click record
      def update
        if @tab_click.update(tab_click_params)
          redirect_to admin_tab_clicks_path, notice: update_successful_notice
        else
          render :edit, status: :unprocessable_entity
        end
      end
  
      # Delete a tab click record
      def destroy
        @tab_click.destroy
        redirect_to admin_tab_clicks_path, notice: destroy_successful_notice
      end
  
      private
  
      # Load the restaurant for the current user
      def set_restaurant
        @restaurant = Restaurant.find(current_user.restaurant_id)
      end
  
      # Load a specific tab click based on the ID
      def set_tab_click
        @tab_click = @restaurant.tab_clicks.find(params[:id])
      end
  
      # Strong parameters to allow only safe attributes
      def tab_click_params
        permitted_attributes(TabClick)
      end
    end
  end
  