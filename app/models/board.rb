class Board < ApplicationRecord
  validates :name, presence: true

  has_many :cards, dependent: :destroy
  has_many :participations, dependent: :destroy
  has_many :users, through: :participations
end
