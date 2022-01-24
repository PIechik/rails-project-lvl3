# frozen_string_literal: true

module Web
  class ProfilesController < ApplicationController
    def index
      authorize Bulletin, :profile?
      @bulletins = current_user.bulletins.order(created_at: :desc)
    end
  end
end
