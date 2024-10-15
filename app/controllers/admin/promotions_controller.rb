module Admin
  class PromotionsController < ApplicationController
    before_action :set_restaurant
    before_action :set_promotion, only: %i[show edit update destroy]
    before_action -> { authorize @promotion || Promotion }

    decorates_assigned :promotion, :promotions
    add_controller_helpers :promotions, only: :index

    def index
      @promotions = policy_scope(Promotion).where(restaurant: @restaurant).order(view_count: :desc)
    end

    def show
    end

    def new
      @promotion = @restaurant.promotions.new
    end

    def edit
    end

    def create
      @promotion = @restaurant.promotions.new(promotion_params)

      if @promotion.save
        redirect_to admin_promotions_path
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @promotion.update(promotion_params)
        redirect_to admin_promotions_path
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @promotion.destroy
      redirect_to admin_promotions_path
    end

    private

    def set_restaurant
      @restaurant = Restaurant.find(current_user.restaurant_id)
    end

    def set_promotion
      @promotion = @restaurant.promotions.find(params[:id])
    end

    def promotion_params
      permitted_attributes(Promotion)
    end
  end
end
