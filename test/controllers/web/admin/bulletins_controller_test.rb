# frozen_string_literal: true

require 'test_helper'

module Web
  module Admin
    class BulletinsControllerTest < ActionDispatch::IntegrationTest
      setup do
        sign_in_user(users(:one))
      end

      test 'should open index page' do
        get admin_bulletins_path

        assert_response :success
      end
    end
  end
end
