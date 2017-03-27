class CardSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :state, :board_id, :user, :doer,
             :accessible, :vote

  def user
    object.user.email
  end

  def doer
    object.doer.email
  end

  def accessible
    object.user_id == current_user.id || current_user.manage?(object.board)
  end

  def vote
    current_user.vote_for object
  end
end
