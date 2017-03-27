class Card < ApplicationRecord
  belongs_to :board
  belongs_to :user
  belongs_to :doer, class_name: 'User'
  has_many :card_marks, dependent: :destroy

  validates :title, :content, :board, :user, presence: true
  
  #
  # state_machine :initial => 'idea' do
  #   event :accept  do
  #     transition 'idea' => 'to-do'
  #   end
  #
  #   event :complete do
  #     transition 'to-do' => 'on-review'
  #   end
  #
  #   event :commit do
  #     transition 'on-review' => 'commited'
  #   end
  #
  #   event :refuse do
  #     transition 'on-review' => 'to-do'
  #   end
  #
  #   event :finish do
  #     transition 'commited' => 'done'
  #   end
  # end
end
