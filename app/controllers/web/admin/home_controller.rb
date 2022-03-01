# frozen_string_literal: true

module Web
  module Admin
    class HomeController < ApplicationController
      def index
        @bulletins = Bulletin.under_moderation.order(created_at: :desc).page(params[:page])
      end
    end
  end
end
