# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
    def sign_in_user(user = nil)
      if user&.admin?
        post sessions_path, params: { user: { email: user.email } }
      else
        config_omniauth_mock(user)
        post '/auth/github'
        follow_redirect!
      end
    end

    def config_omniauth_mock(user = nil)
      params = if user
                 existing_user_params(user)
               else
                 new_user_params
               end
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(params)
      Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:github]
    end

    private

    def new_user_params
      {
        provider: 'github',
        uid: Faker::Internet.uuid,
        info: {
          nickname: Faker::Internet.username,
          email: Faker::Internet.email
        }
      }
    end

    def existing_user_params(user)
      {
        provider: 'github',
        uid: user.uid,
        info: {
          nickname: user.name,
          email: user.email
        }
      }
    end
  end
end
