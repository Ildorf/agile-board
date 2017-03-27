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

  def author? object
    id == object.user_id
  end

  def manage_card? card
    author?(card) || manage?(card.board)
  end

  def vote_for card
    card_marks.where(card_id: card.id).first.try(:id)
  end
end
