class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable

  has_many :participations, dependent: :destroy
  has_many :boards, through: :participations
  has_many :card_marks, dependent: :destroy

  def manage? board
    participation = participations.where(board_id: board.id).first
    participation.present? && participation.role == 'manager'
  end

  def author? card
    id == card.id
  end
end
