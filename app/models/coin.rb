class Coin < ApplicationRecord

  belongs_to :mining_type

  validates :acronym, presence: true
  validates :description, presence: true
end
