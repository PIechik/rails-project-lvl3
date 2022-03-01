# frozen_string_literal: true

module Web
  module Admin
    class BulletinsController < Web::Admin::ApplicationController
      def index
        @q = Bulletin.all.ransack(params[:q])
        @bulletins = @q.result.order(created_at: :desc).page(params[:page])
      end

      def publish
        if resource_bulletin.publish!
          redirect_to admin_bulletins_path, notice: t('success')
        else
          redirect_to admin_bulletins_path, notice: t('fail')
        end
      end

      def reject
        if resource_bulletin.reject!
          redirect_to admin_bulletins_path, notice: t('success')
        else
          redirect_to admin_bulletins_path, notice: t('fail')
        end
      end

      def archive
        if resource_bulletin.archive!
          redirect_to admin_bulletins_path, notice: t('success')
        else
          redirect_to admin_bulletins_path, notice: t('fail')
        end
      end

      private

      def resource_bulletin
        @resource_bulletin ||= Bulletin.find(params[:id])
      end
    end
  end
end
