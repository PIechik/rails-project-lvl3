# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create

  def new; end

  def create
    if user_params
      sign_in_as_admin
    else
      @user = User.find_or_create_by_auth(auth_hash)
      session[:user_id] = @user.id
      redirect_to '/'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end

  private

  def user_params
    params.require(:user).permit(:email)
  end

  def sign_in_as_admin
    @user = User.find_by(user_params)
    if @user && @user.role == 'admin'
      session[:user_id] = @user.id
      redirect_to root_path, notice: t('success')
    else
      redirect_to new_session_path, notice: t('admin.wrong_email')
    end
  end
end
