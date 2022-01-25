# frozen_string_literal: true

require 'test_helper'

module Web
  class AuthControllerTest < ActionDispatch::IntegrationTest
    test 'should sign in user through github' do
      config_omniauth_mock
      post auth_request_path(:github)

      follow_redirect!
      assert { session[:user_id] }
      assert_redirected_to root_path
    end
  end
end
