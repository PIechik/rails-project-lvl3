# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :bulletins, dependent: :destroy
end
