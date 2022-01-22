# frozen_string_literal: true

require 'test_helper'

module Web
  module Admin
    class CategoriesControllerTest < ActionDispatch::IntegrationTest
      test 'shold open index if user is admin' do
        sign_in_user(users(:one))
        get admin_categories_path

        assert_response :success
      end

      test 'should open new category page if user is admin' do
        sign_in_user(users(:one))
        get new_admin_category_path

        assert_response :success
      end

      test 'should create new category' do
        sign_in_user(users(:one))
        params = { name: Faker::Lorem.word }
        post admin_categories_path, params: { category: params }

        category = Category.find_by(params)
        assert { category }
        assert_redirected_to admin_categories_path
      end

      test 'should open edit category page' do
        sign_in_user(users(:one))
        get edit_admin_category_path(categories(:one))

        assert_response :success
      end

      test 'should update category' do
        sign_in_user(users(:one))
        category = categories(:one)
        params = { name: Faker::Lorem.word }
        patch admin_category_path(category), params: { category: params }

        category.reload
        assert { category.name == params[:name] }
        assert_redirected_to admin_categories_path
      end

      test 'should destroy category' do
        sign_in_user(users(:one))
        category = categories(:one)
        delete admin_category_path(category)

        assert { !Category.find_by(id: category.id) }
        assert_redirected_to admin_categories_path
      end
    end
  end
end
