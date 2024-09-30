module Admin
  class UsersController < ApplicationController

    before_action :set_user, only: %i[edit update show login_as]
    before_action -> { authorize @user || User }

    decorates_assigned :user, :users
    add_controller_helpers :users, only: :index

    def index
      @users = policy_scope(User).order(:first_name, :last_name)
    end

    def show
    end

    def edit
    end

    def update
      @user.assign_attributes(user_params)
      @user.skip_reconfirmation!
      if @user.save
        ensure_authentication!
        redirect_to admin_users_path, notice: update_successful_notice
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def set_user
      @user = policy_scope(User).find(params[:id])
    end

    def user_params
      return permitted_attributes(User) if params.dig(:user, :password).present?

      permitted_attributes(User).except(:password, :password_confirmation)
    end

    def ensure_authentication!
      return if @user.id != current_user.id

      bypass_sign_in(@user)
    end
  end
end
