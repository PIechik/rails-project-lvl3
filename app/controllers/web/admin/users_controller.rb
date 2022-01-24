# frozen_string_literal: true

module Web
  module Admin
    class UsersController < ApplicationController
      def index
        @users = User.all
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
        params.require(:user).permit(:name, :email, :strategy, :uid, :role)
      end
    end
  end
end
