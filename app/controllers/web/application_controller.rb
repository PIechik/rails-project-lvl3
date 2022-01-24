# frozen_string_literal: true

module Web
  class ApplicationController < ApplicationController
    include Pundit

    helper_method :current_user
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    private

    def user_not_authorized
      flash[:alert] = t('pundit.default')
      redirect_to(request.referer || root_path)
    end
  end
end
