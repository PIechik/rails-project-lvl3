# frozen_string_literal: true

module Web
  class BulletinsController < Web::ApplicationController
    before_action :authorize!, only: %i[new create]
    def index
      @bulletins = Bulletin.order(created_at: :desc)
    end

    def show
      @bulletin = Bulletin.find(params[:id])
    end

    def new
      @bulletin = Bulletin.new
    end

    def create
      @bulletin = current_user.bulletins.build(bulletin_params)

      if @bulletin.save
        redirect_to @bulletin, notice: t('success')
      else
        render :new, notice: t('fail')
      end
    end

    private

    def bulletin_params
      params.require(:bulletin).permit(:image, :name, :description, :category_id)
    end
  end
end
