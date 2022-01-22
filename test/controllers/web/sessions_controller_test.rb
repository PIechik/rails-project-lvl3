# frozen_string_literal: true

require 'test_helper'

module Web
  class SessionsControllerTest < ActionDispatch::IntegrationTest
    test 'should open sign in page' do
      get new_session_path

      assert_response :success
    end

    test 'should sign in as admin' do
      post sessions_path, params: { user: { email: users(:one).email } }

      assert { session[:user_id] == users(:one).id }
      assert_redirected_to root_path
    end

    test 'shouldn\'t sign in via email if not admin' do
      post sessions_path, params: { user: { email: users(:two).email } }

      assert { !session[:user_id] }
      assert_redirected_to new_session_path
    end

    test 'should sign in user through github' do
      config_omniauth_mock
      post '/auth/github'

      follow_redirect!
      assert { session[:user_id] }
      assert_redirected_to root_path
    end

    test 'should sign out' do
      sign_in_user(users(:one))
      delete session_path(users(:one).id)

      assert { !session[:user_id] }
      assert_redirected_to root_path
    end
  end
end
