# frozen_string_literal: true

module Web
  module Admin
    class UsersController < Web::Admin::ApplicationController
      def index
        @q = User.all.ransack(params[:q])
        @users = @q.result.order(created_at: :desc).page(params[:page])
      end

      def new
        @user = User.new
      end

      def create
        @user = User.new(user_params)

        if @user.save
          redirect_to admin_users_path, notice: t('success')
        else
          render :new, notice: t('fail')
        end
      end

      def edit
        @user = User.find(params[:id])
      end

      def update
        @user = User.find(params[:id])

        if @user.update(user_params)
          redirect_to admin_users_path, notice: t('success')
        else
          render :edit, notice: t('fail')
        end
      end

      def destroy
        @user = User.find(params[:id])

        @user.destroy
        redirect_to admin_users_path, notice: t('success')
      end

      private

      def user_params
        params.require(:user).permit(:name, :email, :admin)
      end
    end
  end
end
