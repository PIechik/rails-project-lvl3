# frozen_string_literal: true

module Web
  module Admin
    class BulletinsController < ApplicationController
      def index
        @q = Bulletin.all.ransack(params[:q])
        @bulletins = @q.result.order(created_at: :desc)
        authorize([:admin, @bulletins])
      end

      def publish
        @bulletin = Bulletin.find(params[:id])
        authorize([:admin, @bulletin])
        @bulletin.publish

        if @bulletin.save
          redirect_to admin_bulletins_path, notice: t('success')
        else
          redirect_to admin_bulletins_path, notice: t('fail')
        end
      end

      def reject
        @bulletin = Bulletin.find(params[:id])
        authorize([:admin, @bulletin])
        @bulletin.reject

        if @bulletin.save
          redirect_to admin_bulletins_path, notice: t('success')
        else
          redirect_to admin_bulletins_path, notice: t('fail')
        end
      end

      def archive
        @bulletin = Bulletin.find(params[:id])
        authorize([:admin, @bulletin])
        @bulletin.archive

        if @bulletin.save
          redirect_to admin_bulletins_path, notice: t('success')
        else
          redirect_to admin_bulletins_path, notice: t('fail')
        end
      end
    end
  end
end
