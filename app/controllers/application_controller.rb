# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit
  include AuthConcern

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
end
