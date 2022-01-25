# frozen_string_literal: true

class User < ApplicationRecord
  has_many :bulletins, dependent: :destroy

  def self.find_or_create_by_auth(auth_hash)
    user = User.find_or_create_by(
      email: auth_hash['info']['email'],
      first_name: auth_hash['info']['first_name'],
      last_name: auth_hash['info']['last_name']
    )
    user.save
    user
  end
end
