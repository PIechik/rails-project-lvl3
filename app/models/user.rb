# frozen_string_literal: true

class User < ApplicationRecord
  has_many :bulletins, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true

  def self.find_or_create_by_auth(auth_hash)
    user = User.find_or_create_by(
      email: auth_hash['info']['email'],
      name: auth_hash['info']['name']
    )
    user.save
    user
  end
end
