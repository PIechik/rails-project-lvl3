# frozen_string_literal: true

require 'test_helper'

module Web
  module Admin
    class UsersControllerTest < ActionDispatch::IntegrationTest
      setup do
        sign_in_user(users(:one))
      end

      test 'should open index page' do
        skip
        get admin_users_path

        assert_response :success
      end

      test 'should open new user page' do
        skip
        get new_admin_user_path

        assert_response :success
      end

      test 'should create new user' do
        skip
        params = {
          name: Faker::Internet.username,
          email: Faker::Internet.email,
          strategy: 'github',
          uid: Faker::Internet.uuid,
          role: 'user'
        }
        post admin_users_path, params: { user: params }

        user = User.find_by(params)
        assert { user }
        assert_redirected_to admin_users_path
      end

      test 'should open edit page' do
        skip
        get edit_admin_user_page(users(:two))

        assert_response :success
      end

      test 'should update user' do
        skip
        user = users(:two)
        params = { email: Faker::Internet.email }
        patch admin_user_path(user), params: { user: params }

        user.reload
        assert { user.email == params[:email] }
        assert_redirected_to admin_users_path
      end

      test 'should destroy user' do
        skip
        user = users(:two)
        delete admin_user_path(user)

        assert { !User.find_by(id: user.id) }
        assert_redirected_to admin_users_path
      end
    end
  end
end
