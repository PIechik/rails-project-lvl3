# frozen_string_literal: true

require 'test_helper'

module Web
  class UsersControllerTest < ActionDispatch::IntegrationTest
    test 'should open sign up page' do
      get new_user_path

      assert_response :success
    end
  end
end
