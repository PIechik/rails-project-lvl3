# frozen_string_literal: true

module Web
  class AuthController < Web::ApplicationController
    def callback
      @user = User.find_or_create_by_auth(auth_hash)
      session[:user_id] = @user.id
      redirect_to root_path
    end

    protected

    def auth_hash
      request.env['omniauth.auth']
    end
  end
end
