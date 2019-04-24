class Ticket < ApplicationRecord
  require 'securerandom'

  belongs_to :guest
  validates :code, presence: true

  def generate_code
    self.code = SecureRandom.hex(32).to_s
  end
end
