# frozen_string_literal: true

require 'test_helper'

module Web
  class ProfilesControllerTest < ActionDispatch::IntegrationTest
    test 'should open profile page' do
      sign_in_user(users(:one))
      get profiles_path

      assert_response :success
    end
  end
end
