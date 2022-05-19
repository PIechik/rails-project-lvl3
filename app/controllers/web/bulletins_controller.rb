# frozen_string_literal: true

module Web
  class BulletinsController < Web::ApplicationController
    def index
      @categories = Category.all
      @q = Bulletin.published.ransack(params[:q])
      @bulletins = @q.result.order(created_at: :desc).page(params[:page]).per(20)
    end

    def show; end

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
        render :new, notice: t('error', model: 'bulletin', errors: @bulletin.errors.full_messages)
      end
    end

    def edit
      authorize resource_bulletin
    end

    def update
      authorize resource_bulletin

      if resource_bulletin.update(bulletin_params)
        redirect_to profile_path, notice: t('success')
      else
        render :edit, notice: t('error', model: 'bulletin', errors: resource_bulletin.errors.full_messages)
      end
    end

    def destroy
      authorize resource_bulletin

      resource_bulletin.destroy
      redirect_to profile_path
    end

    def moderate
      authorize resource_bulletin

      redirect_to profile_path, notice: t("bulletins.notice.to_moderation#{locale_name_postfix(resource_bulletin.send_to_moderate!)}")
    end

    def archive
      authorize resource_bulletin

      redirect_to profile_path, notice: t("bulletins.notice.archiving#{locale_name_postfix(resource_bulletin.archive!)}")
    end

    private

    def bulletin_params
      params.require(:bulletin).permit(:image, :title, :description, :category_id)
    end
  end
end
