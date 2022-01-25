# frozen_string_literal: true

module Web
  class ProfilesController < ApplicationController
    def index
      authorize Bulletin, :profile?
      @q = current_user.bulletins.ransack(params[:q])
      @bulletins = @q.result.order(created_at: :desc).page(params[:page])
    end
  end
end
