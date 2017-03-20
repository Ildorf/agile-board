class CardSerializer < ActiveModel::Serializer
  attributes :id, :content, :status, :board_id
end
