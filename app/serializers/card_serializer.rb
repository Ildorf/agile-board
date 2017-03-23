class CardSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :status, :board_id, :user, :doer, :accessible

  def user
    object.user.email
  end

  def doer
    object.doer.email
  end

  def accessible
    object.user_id == current_user.id || current_user.manage?(object.board)
  end
end
