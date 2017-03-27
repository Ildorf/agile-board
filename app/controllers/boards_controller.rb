class BoardsController < ApplicationController
  before_action :authenticate_user!

  def show
    @board = Board.includes(:users).find(params[:id])
    @users = User.where.not(id: Participation.where(board_id: @board.id)
                                              .pluck(:user_id))
                 .map {|u| [u.email, u.id] }
  end

  def index
  end
end
