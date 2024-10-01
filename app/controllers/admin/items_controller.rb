module Admin
    class ItemsController < ApplicationController
      before_action :set_restaurant
      before_action :set_item, only: %i[edit update show destroy]
      before_action -> { authorize @item || Item }
  
      decorates_assigned :item, :items
      add_controller_helpers :items, only: :index
  
      def index
        @items = policy_scope(Item).where(restaurant: @restaurant).order(name: :asc)
      end
  
      def show
      end
  
      def new
        @item = @restaurant.items.new
      end
  
      def edit
      end
  
      def create
        @item = @restaurant.items.new(item_params)
  
        if @item.save
          redirect_to admin_items_path, notice: create_successful_notice
        else
          render :new, status: :unprocessable_entity
        end
      end
  
      def update
        @item.assign_attributes(item_params)
  
        if @item.save
          redirect_to admin_items_path, notice: update_successful_notice
        else
          render :edit, status: :unprocessable_entity
        end
      end
  
      def destroy
        @item.destroy
        redirect_to admin_items_path, notice: destroy_successful_notice
      end
  
      private
  
      def set_restaurant
        @restaurant = Restaurant.find(current_user.restaurant_id)
      end
  
      def set_item
        @item = policy_scope(@restaurant.items).find(params[:id])
      end
  
      def item_params
        permitted_attributes(Item)
      end
    end
  end
  