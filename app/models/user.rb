# frozen_string_literal: true

class User < ApplicationRecord
  def find_or_create_by_auth(auth_hash)
    user = User.find_or_create_by(
      strategy: auth_hash['provider'],
      uid: auth_hash['uid'],
      name: auth_hash['info']['nickname'],
      email: auth_hash['info']['email']
    )
    user.save
    user
  end
end
