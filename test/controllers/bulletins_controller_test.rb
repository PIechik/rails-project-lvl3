# frozen_string_literal: true

require 'test_helper'

class BulletinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bulletin_params = {
      name: Faker::Creature::Animal.name,
      description: Faker::Lorem.paragraph,
      category_id: categories(:two).id,
      image: fixture_file_upload('dog.jpeg', 'image/jpeg')
    }
  end

  test 'should open index page' do
    get bulletins_path

    assert_response :success
  end

  test 'should open show page' do
    get bulletin_path(bulletins(:one))

    assert_response :success
  end

  test 'should open new bulletin page if user signed in' do
    sign_in_user(users(:one))
    get new_bulletin_path

    assert_response :success
  end

  test 'should redirect from new bulletin page if user is not signed in' do
    get new_bulletin_path

    assert_redirected_to new_session_path
  end

  test 'should create new bulletin' do
    sign_in_user(users(:one))
    post bulletins_path, params: { bulletin: @bulletin_params }

    bulletin = Bulletin.find_by(name: @bulletin_params[:name])
    assert { bulletin }
    assert_redirected_to bulletin
  end

  test 'shouldn\'t create bulletin if user is not signed in' do
    post bulletins_path, params: { bulletin: @bulletin_params }

    bulletin = Bulletin.find_by(name: @bulletin_params[:name])
    assert { !bulletin }
    assert_redirected_to new_session_path
  end
end
