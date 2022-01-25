# frozen_string_literal: true

module Web
  class BulletinsController < Web::ApplicationController
    def index
      @q = Bulletin.published.ransack(params[:q])
      @bulletins = @q.result.order(created_at: :desc).page(params[:page])
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
      authorize Bulletin
      @bulletin = current_user.bulletins.build(bulletin_params)

      if @bulletin.save
        redirect_to @bulletin, notice: t('success')
      else
        render :new, notice: t('fail')
      end
    end

    def edit
      @bulletin = Bulletin.find(params[:id])
      authorize @bulletin
    end

    def update
      @bulletin = Bulletin.find(params[:id])
      authorize @bulletin

      if @bulletin.update(bulletin_params)
        redirect_to profile_path, notice: t('success')
      else
        render :edit, notice: t('fail')
      end
    end

    def destroy
      @bulletin = Bulletin.find(params[:id])
      authorize @bulletin

      @bulletin.destroy
      redirect_to profile_path
    end

    def moderate
      @bulletin = Bulletin.find(params[:id])
      authorize @bulletin
      @bulletin.moderate

      if @bulletin.save
        redirect_to profile_path, notice: t('success')
      else
        redirect_to profile_path, notice: t('fail')
      end
    end

    def archive
      @bulletin = Bulletin.find(params[:id])
      authorize @bulletin
      @bulletin.archive

      if @bulletin.save
        redirect_to profile_path, notice: t('success')
      else
        redirect_to profile_path, notice: t('fail')
      end
    end

    private

    def bulletin_params
      params.require(:bulletin).permit(:image, :name, :description, :category_id)
    end
  end
end
