module Admin
  class RestaurantsController < ApplicationController

    before_action :set_restaurant, only: %i[edit update show]
    before_action -> { authorize @restaurant || Restaurant }

    decorates_assigned :restaurant, :restaurants
    add_controller_helpers :restaurants, only: :index

    def index
      @restaurants = policy_scope(Restaurant).order(:name)
    end

    def show
    end

    def new
      @restaurant = Restaurant.new
    end

    def edit
    end

    def create
      @restaurant = Restaurant.new(permitted_attributes(Restaurant))

      if @restaurant.save
        redirect_to [:admin, @restaurant], notice: create_successful_notice
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      @restaurant.assign_attributes(restaurant_params)

      if @restaurant.save
        redirect_to admin_restaurants_path, notice: update_successful_notice
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def set_restaurant
      @restaurant = policy_scope(Restaurant).find(params[:id])
    end

    def restaurant_params
      permitted_attributes(Restaurant)
    end
  end
end
