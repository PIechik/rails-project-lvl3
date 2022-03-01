# frozen_string_literal: true

module Web
  module Admin
    class UsersController < Web::Admin::ApplicationController
      helper_method :resource_user

      def index
        @q = User.all.ransack(params[:q])
        @users = @q.result.order(created_at: :desc).page(params[:page])
      end

      def new; end

      def create
        @user = User.new(user_params)

        if @user.save
          redirect_to admin_users_path, notice: t('success')
        else
          render :new, notice: t('error', model: 'user', errors: @user.errors.full_messages)
        end
      end

      def edit; end

      def update
        if resource_user.update(user_params)
          redirect_to admin_users_path, notice: t('success')
        else
          render :edit, notice: t('error', model: 'user', errors: resource_user.errors.full_messages)
        end
      end

      def destroy
        resource_user.destroy
        redirect_to admin_users_path, notice: t('success')
      end

      private

      def user_params
        params.require(:user).permit(:name, :email, :admin)
      end

      def resource_user
        @resource_user ||= User.find(params[:id])
      end
    end
  end
end
