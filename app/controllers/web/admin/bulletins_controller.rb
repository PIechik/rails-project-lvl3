# frozen_string_literal: true

module Web
  module Admin
    class BulletinsController < ApplicationController
      def index
        @q = Bulletin.all.ransack(params[:q])
        @bulletins = @q.result.order(created_at: :desc).page(params[:page])
        authorize([:admin, @bulletins])
      end

      def publish
        @bulletin = Bulletin.find(params[:id])
        authorize([:admin, @bulletin])

        if @bulletin.publish && @bulletin.save
          redirect_to admin_bulletins_path, notice: t('success')
        else
          redirect_to admin_bulletins_path, notice: t('fail')
        end
      end

      def reject
        @bulletin = Bulletin.find(params[:id])
        authorize([:admin, @bulletin])

        if @bulletin.reject && @bulletin.save
          redirect_to admin_bulletins_path, notice: t('success')
        else
          redirect_to admin_bulletins_path, notice: t('fail')
        end
      end

      def archive
        @bulletin = Bulletin.find(params[:id])
        authorize([:admin, @bulletin])

        if @bulletin.archive && @bulletin.save
          redirect_to admin_bulletins_path, notice: t('success')
        else
          redirect_to admin_bulletins_path, notice: t('fail')
        end
      end
    end
  end
end
