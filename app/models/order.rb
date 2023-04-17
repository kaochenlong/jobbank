# frozen_string_literal: true

class Order < ApplicationRecord
  include AASM

  belongs_to :user
  before_create :serial_generator

  # state machine
  aasm column: 'status', no_direct_assignment: true do
    state :pending, initial: true
    state :paid, :failed, :cancelled, :refunded

    event :pay do
      transitions from: :pending, to: :paid

      after do
        user.update(role: 'vip')
      end
    end

    event :refund do
      transitions from: :paid, to: :refunded
    end

    event :fail do
      transitions from: :pending, to: :failed
    end

    event :cancel do
      transitions from: %i[pending paid], to: :cancelled
    end
  end

  private

  def serial_generator
    self.serial = Time.current.strftime('%Y%m%d') + SecureRandom.alphanumeric(8)
  end
end
