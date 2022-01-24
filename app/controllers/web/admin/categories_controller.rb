# frozen_string_literal: true

module Web
  module Admin
    class CategoriesController < ApplicationController
      def index
        @categories = Category.all
        authorize([:admin, @categories])
      end

      def new
        @category = Category.new
        authorize([:admin, @category])
      end

      def create
        @category = Category.new(category_params)
        authorize([:admin, @category])

        if @category.save
          redirect_to admin_categories_path, notice: t('success')
        else
          render :new, notice: t('fail')
        end
      end

      def edit
        @category = Category.find(params[:id])
        authorize([:admin, @category])
      end

      def update
        @category = Category.find(params[:id])
        authorize([:admin, @category])

        if @category.update(category_params)
          redirect_to admin_categories_path, notice: t('success')
        else
          render :edit, notice: t('fail')
        end
      end

      def destroy
        @category = Category.find(params[:id])
        authorize([:admin, @category])

        @category.destroy
        redirect_to admin_categories_path, notice: t('success')
      end

      private

      def category_params
        params.require(:category).permit(:name)
      end
    end
  end
end
