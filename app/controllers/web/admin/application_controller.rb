# frozen_string_literal: true

module Web
  module Admin
    class ApplicationController < Web::ApplicationController
      layout 'web/admin'
      before_action :require_admin!

      def require_admin!
        user_not_authorized unless current_user&.admin?
      end
    end
  end
end
