# frozen_string_literal: true

module Web
  class ApplicationController < ApplicationController
    include Pundit
    include AuthConcern

    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    private

    def locale_name_postfix(returned_value)
      returned_value ? '' : '_failed'
    end
  end
end
