module Admin
  class DailyVisitsController < ApplicationController
    before_action :set_restaurant
    before_action :set_daily_visit, only: %i[edit update show destroy]
    before_action -> { authorize @daily_visit || DailyVisit }

    decorates_assigned :daily_visit, :daily_visits
    add_controller_helpers :daily_visits, only: :index

    def index
      @daily_visits = policy_scope(DailyVisit).where(restaurant: @restaurant).order(date: :asc)
    end

    def show
    end

    def new
      @daily_visit = @restaurant.daily_visits.new
    end

    def edit
    end

    def create
      @daily_visit = @restaurant.daily_visits.new(daily_visit_params)
      set_weekday(@daily_visit)

      if @daily_visit.save
        redirect_to admin_daily_visits_path, notice: create_successful_notice
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      @daily_visit.assign_attributes(daily_visit_params)
      set_weekday(@daily_visit)

      if @daily_visit.save
        redirect_to admin_daily_visits_path, notice: update_successful_notice
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @daily_visit.destroy
      redirect_to admin_daily_visits_path, notice: destroy_successful_notice
    end

    private

    # Instead of using params, we load the restaurant from the current_user
    def set_restaurant
      @restaurant = Restaurant.find(current_user.restaurant_id)
    end

    def set_daily_visit
      @daily_visit = policy_scope(@restaurant.daily_visits).find(params[:id])
    end

    def daily_visit_params
      permitted_attributes(DailyVisit)
    end

    # Set the weekday based on the date in the controller
    def set_weekday(daily_visit)
      if daily_visit.date.present?
        daily_visit.weekday = daily_visit.date.strftime("%A")
      end
    end
  end
end
