# frozen_string_literal: true

module Admin
  class BulletinPolicy < Admin::AdminPolicy
    def publish?
      admin?
    end

    def reject?
      admin?
    end

    def archive?
      admin?
    end
  end
end
