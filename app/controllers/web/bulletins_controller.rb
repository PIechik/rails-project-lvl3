# frozen_string_literal: true

module Web
  class BulletinsController < Web::ApplicationController
    def index
      @bulletins = Bulletin.order(created_at: :desc)
      authorize @bulletins
    end

    def show
      @bulletin = Bulletin.find(params[:id])
      authorize @bulletin
    end

    def new
      @bulletin = Bulletin.new
      authorize @bulletin
    end

    def create
      @bulletin = current_user.bulletins.build(bulletin_params)
      authorize @bulletin

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
