class BoardSerializer < ActiveModel::Serializer
  attributes :id, :name, :accessible

  def accessible
    current_user.manage?(object)
  end
end
