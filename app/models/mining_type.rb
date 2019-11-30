class MiningType < ApplicationRecord

  has_many :coins

  validates :acronym, presence: true
  validates :description, presence: true
end
