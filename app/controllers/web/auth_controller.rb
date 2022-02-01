# frozen_string_literal: true

module Web
  class AuthController < Web::ApplicationController
    def callback
      user_info = auth_hash['info']
      @user = User.find_or_create_by(
        email: user_info['email'],
        name: user_info['name'] || user_info['nickname']
      )
      if @user.save
        session[:user_id] = @user.id
        redirect_to root_path, notice: t('success')
      else
        redirect_to new_session_path, notice: t('fail')
      end
    end

    protected

    def auth_hash
      request.env['omniauth.auth']
    end
  end
end
