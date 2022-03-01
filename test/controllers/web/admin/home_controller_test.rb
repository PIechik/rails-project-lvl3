# frozen_string_literal: true

require 'test_helper'

module Web
  module Admin
    class HomeControllerTest < ActionDispatch::IntegrationTest
      test 'should open under moderation page' do
        sign_in_user(users(:one))
        get admin_root_path

        assert_response :success
      end
    end
  end
end
