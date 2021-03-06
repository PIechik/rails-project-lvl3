# frozen_string_literal: true

require 'test_helper'

module Web
  module Admin
    class BulletinsControllerTest < ActionDispatch::IntegrationTest
      setup do
        sign_in_user(users(:one))
        @bulletin = bulletins(:under_moderation)
      end

      test 'should open index page' do
        get admin_bulletins_path

        assert_response :success
      end

      test 'should publish bulletin' do
        patch publish_admin_bulletin_path(@bulletin)

        @bulletin.reload
        assert { @bulletin.published? }
      end

      test 'should reject bulletin' do
        patch reject_admin_bulletin_path(@bulletin)

        @bulletin.reload
        assert { @bulletin.rejected? }
      end

      test 'should archive bulletin' do
        patch archive_admin_bulletin_path(@bulletin)

        @bulletin.reload
        assert { @bulletin.archived? }
      end
    end
  end
end
