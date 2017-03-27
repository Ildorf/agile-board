class Participation < ApplicationRecord
  belongs_to :user
  belongs_to :board

  validates :user_id, :board_id, presence: true
  validates :user_id, uniqueness: { scope: :board_id }
end
