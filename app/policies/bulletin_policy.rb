# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    user
  end

  def update?
    author?
  end

  def destroy?
    author?
  end

  def profile?
    user
  end

  def moderate?
    author?
  end

  def archive?
    author?
  end

  private

  def author?
    record.user == user
  end
end
