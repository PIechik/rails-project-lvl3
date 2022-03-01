# frozen_string_literal: true

module Web
  module Admin
    class CategoriesController < Web::Admin::ApplicationController
      helper_method :resource_category

      def index
        @q = Category.all.ransack(params[:q])
        @categories = @q.result.order(created_at: :desc).page(params[:page])
      end

      def new; end

      def create
        @category = Category.new(category_params)

        if @category.save
          redirect_to admin_categories_path, notice: t('success')
        else
          render :new, notice: t('error', model: 'category', errors: @category.errors.full_messages)
        end
      end

      def edit; end

      def update
        if resource_category.update(category_params)
          redirect_to admin_categories_path, notice: t('success')
        else
          render :edit, notice: t('error', model: 'category', errors: resource_category.errors.full_messages)
        end
      end

      def destroy
        resource_category.destroy
        redirect_to admin_categories_path, notice: t('success')
      end

      private

      def resource_category
        @resource_category ||= Category.find(params[:id])
      end

      def category_params
        params.require(:category).permit(:name)
      end
    end
  end
end
