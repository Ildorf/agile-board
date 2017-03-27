class CardMark < ApplicationRecord
  belongs_to :card
  belongs_to :user

  validates :card_id, uniqueness: { scope: :user_id }
end
