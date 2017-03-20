class Card < ApplicationRecord
  belongs_to :board

  validates :content, :board, presence: true

  # event :accept  do
  #    transition [:idling, :first_gear] => :parked
  #  end
  #
  #  event :ignite do
  #    transition :stalled => same, :parked => :idling
  #  end
  #
  #  event :idle do
  #    transition :first_gear => :idling
  #  end
  #
  #  event :shift_up do
  #    transition :idling => :first_gear, :first_gear => :second_gear, :second_gear => :third_gear
  #  end
  #
  #  event :shift_down do
  #    transition :third_gear => :second_gear, :second_gear => :first_gear
  #  end
  #
  #  event :crash do
  #    transition all - [:parked, :stalled] => :stalled, :if => lambda {|vehicle| !vehicle.passed_inspection?}
  #  end
end
