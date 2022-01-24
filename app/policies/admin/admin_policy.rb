# frozen_string_literal: true

module Admin
  class AdminPolicy < ApplicationPolicy
    def index?
      admin?
    end

    def create?
      admin?
    end

    def update?
      admin?
    end

    def destroy?
      admin?
    end

    private

    def admin?
      user&.admin?
    end
  end
end
