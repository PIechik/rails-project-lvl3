# frozen_string_literal: true

class Bulletin < ApplicationRecord
  include AASM

  belongs_to :user
  belongs_to :category
  has_one_attached :image

  validates :title, presence: true
  validates :description, presence: true
  validates :image, attached: true

  aasm whiny_transitions: false, column: :state do
    state :draft, initial: true
    state :under_moderation, :published, :rejected, :archived

    event :moderate do
      transitions from: :draft, to: :under_moderation
    end

    event :publish do
      transitions from: :under_moderation, to: :published
    end

    event :reject do
      transitions from: :under_moderation, to: :rejected
    end

    event :archive do
      transitions from: %i[draft under_moderation published rejected], to: :archived
    end
  end
end
