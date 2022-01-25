# frozen_string_literal: true

module Web
  module Admin
    class UsersController < ApplicationController
      def index
        @q = User.all.ransack(params[:q])
        @users = @q.result.order(created_at: :desc).page(params[:page])
        authorize([:admin, @users])
      end

      def new
        @user = User.new
        authorize([:admin, @user])
      end

      def create
        @user = User.new(user_params)
        authorize([:admin, @user])

        if @user.save
          redirect_to admin_users_path, notice: t('success')
        else
          render :new, notice: t('fail')
        end
      end

      def edit
        @user = User.find(params[:id])
        authorize([:admin, @user])
      end

      def update
        @user = User.find(params[:id])
        authorize([:admin, @user])

        if @user.update(user_params)
          redirect_to admin_users_path, notice: t('success')
        else
          render :edit, notice: t('fail')
        end
      end

      def destroy
        @user = User.find(params[:id])
        authorize([:admin, @user])

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
