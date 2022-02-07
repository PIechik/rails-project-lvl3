# frozen_string_literal: true

module Web
  module Admin
    class ApplicationController < Web::ApplicationController
      layout 'web/admin'
      before_action :require_admin!
    end
  end
end
