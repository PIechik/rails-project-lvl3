# frozen_string_literal: true

module Web
  module Admin
    class BulletinsController < Web::Admin::ApplicationController
      def index
        @q = Bulletin.all.ransack(params[:q])
        @bulletins = @q.result.order(created_at: :desc).page(params[:page])
      end

      def publish
        @bulletin = Bulletin.find(params[:id])

        if @bulletin.publish && @bulletin.save
          redirect_to admin_bulletins_path, notice: t('success')
        else
          redirect_to admin_bulletins_path, notice: t('fail')
        end
      end

      def reject
        @bulletin = Bulletin.find(params[:id])

        if @bulletin.reject && @bulletin.save
          redirect_to admin_bulletins_path, notice: t('success')
        else
          redirect_to admin_bulletins_path, notice: t('fail')
        end
      end

      def archive
        @bulletin = Bulletin.find(params[:id])

        if @bulletin.archive && @bulletin.save
          redirect_to admin_bulletins_path, notice: t('success')
        else
          redirect_to admin_bulletins_path, notice: t('fail')
        end
      end
    end
  end
end
