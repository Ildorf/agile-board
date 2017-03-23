class Participation < ApplicationRecord
  belongs_to :user
  belongs_to :board

  validates :user_id, :board_id, :role, presence: true
end
