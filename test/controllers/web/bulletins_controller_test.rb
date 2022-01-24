# frozen_string_literal: true

require 'test_helper'

module Web
  class BulletinsControllerTest < ActionDispatch::IntegrationTest
    setup do
      sign_in_user(users(:one))
      @bulletin = bulletins(:draft)
    end

    test 'should open index page' do
      get bulletins_path

      assert_response :success
    end

    test 'should open show page' do
      get bulletin_path(bulletins(:draft))

      assert_response :success
    end

    test 'should open new bulletin page' do
      get new_bulletin_path

      assert_response :success
    end

    test 'should create new bulletin' do
      bulletin_params = {
        name: Faker::Creature::Animal.name,
        description: Faker::Lorem.paragraph,
        category_id: categories(:two).id,
        image: fixture_file_upload('dog.jpeg', 'image/jpeg')
      }
      post bulletins_path, params: { bulletin: bulletin_params }

      bulletin = Bulletin.find_by(name: bulletin_params[:name])
      assert { bulletin }
      assert_redirected_to bulletin
    end

    test 'should open edit page' do
      get edit_bulletin_path(@bulletin)

      assert_response :success
    end

    test 'should update bulletin' do
      params = { name: Faker::Lorem.word }
      patch bulletin_path(@bulletin), params: { bulletin: params }

      @bulletin.reload
      assert { @bulletin.name == params[:name] }
      assert_redirected_to profile_path
    end

    test 'should destroy bulletin' do
      delete bulletin_path(@bulletin)

      assert { !Bulletin.find_by(id: @bulletin.id) }
      assert_redirected_to profile_path
    end

    test 'should send bulletin to moderation' do
      patch moderate_bulletin_path(@bulletin)

      @bulletin.reload
      assert { @bulletin.under_moderation? }
      assert_redirected_to profile_path
    end

    test 'should archive bulletin' do
      patch archive_bulletin_path(@bulletin)

      @bulletin.reload
      assert { @bulletin.archived? }
      assert_redirected_to profile_path
    end
  end
end
