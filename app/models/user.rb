# frozen_string_literal: true

class User < ApplicationRecord
  has_many :bulletins, dependent: :destroy

  def self.find_or_create_by_auth(auth_hash)
    user = User.find_or_create_by(
      email: auth_hash['info']['email'],
      strategy: auth_hash['provider'],
      uid: auth_hash['uid'],
      name: auth_hash['info']['nickname']
    )
    user.save
    user
  end
end
