# frozen_string_literal: true

module Web
  class ApplicationController < ApplicationController
    include Pundit
    include AuthConcern

    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
    helper_method :resource_bulletin

    private

    def resource_bulletin
      @resource_bulletin ||= Bulletin.find(params[:id])
    end

    def locale_name_postfix(returned_value)
      returned_value ? '' : '_failed'
    end
  end
end
