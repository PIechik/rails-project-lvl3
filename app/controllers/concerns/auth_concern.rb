# frozen_string_literal: true

module AuthConcern
  extend ActiveSupport::Concern

  included do
    helper_method :signed_in?, :signed_in_as_admin?, :current_user
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def signed_in?
    current_user.present?
  end

  def signed_in_as_admin?
    current_user&.admin?
  end

  def require_admin!
    user_not_authorized unless signed_in_as_admin?
  end

  def user_not_authorized
    flash[:alert] = t('pundit.default')
    redirect_to(request.referer || root_path)
  end
end
