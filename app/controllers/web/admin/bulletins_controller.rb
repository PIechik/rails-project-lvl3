# frozen_string_literal: true

module Web
  module Admin
    class BulletinsController < Web::Admin::ApplicationController
      def index
        @q = Bulletin.ransack(params[:q])
        @bulletins = @q.result.order(created_at: :desc).page(params[:page])
      end

      def publish
        redirect_to admin_root_path, notice: t("bulletins.notice.publishing#{locale_name_postfix(resource_bulletin.publish!)}")
      end

      def reject
        redirect_to admin_root_path, notice: t("bulletins.notice.rejecting#{locale_name_postfix(resource_bulletin.reject!)}")
      end

      def archive
        redirect_to admin_root_path, notice: t("bulletins.notice.archiving#{locale_name_postfix(resource_bulletin.archive!)}")
      end
    end
  end
end
