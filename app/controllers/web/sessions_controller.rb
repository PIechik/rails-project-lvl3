# frozen_string_literal: true

module Web
  class SessionsController < Web::ApplicationController
    skip_before_action :verify_authenticity_token, only: :create

    def new; end

    def create
      @user = User.find_by(user_params)
      if @user&.admin?
        sign_in(@user)
        redirect_to root_path, notice: t('success')
      else
        redirect_to new_session_path, notice: t('sign_in.wrong_email')
      end
    end

    def destroy
      session[:user_id] = nil
      redirect_to root_path
    end

    private

    def user_params
      params.require(:user).permit(:email) if params[:user]
    end
  end
end
