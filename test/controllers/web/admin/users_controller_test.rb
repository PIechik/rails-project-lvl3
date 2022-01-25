# frozen_string_literal: true

require 'test_helper'

module Web
  module Admin
    class UsersControllerTest < ActionDispatch::IntegrationTest
      setup do
        sign_in_user(users(:one))
      end

      test 'should open index page' do
        get admin_users_path

        assert_response :success
      end

      test 'should open new user page' do
        get new_admin_user_path

        assert_response :success
      end

      test 'should create new user' do
        params = {
          name: Faker::Name.name,
          email: Faker::Internet.email,
          admin: false
        }
        post admin_users_path, params: { user: params }

        user = User.find_by(params)
        assert { user }
        assert_redirected_to admin_users_path
      end

      test 'should open edit page' do
        get edit_admin_user_path(users(:two))

        assert_response :success
      end

      test 'should update user' do
        user = users(:two)
        params = { email: Faker::Internet.email }
        patch admin_user_path(user), params: { user: params }

        user.reload
        assert { user.email == params[:email] }
        assert_redirected_to admin_users_path
      end

      test 'should destroy user' do
        user = users(:two)
        delete admin_user_path(user)

        assert { !User.find_by(id: user.id) }
        assert_redirected_to admin_users_path
      end
    end
  end
end
