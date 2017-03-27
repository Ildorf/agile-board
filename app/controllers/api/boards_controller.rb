class Api::BoardsController < ApplicationController
  before_action :authenticate_user!

  def index
    boards = current_user.boards
    render json: boards
  end

  def create
    board = Board.new(board_params)
    if board.save
      board.participations.create(user: current_user, role: 'manager')
      render json: board
    else
      render json: board.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    board = Board.find(params[:id])
    render status: 403 if !current_user.manage?(board)
    if board.update(board_params)
      render json: board
    else
      render json: board.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    board = Board.find(params[:id])
    if current_user.manage?(board)
      board.destroy
      render status: 200, plain: 'Board successfully deleted'
    else
      render status: 403, plain: "You haven't permission for delete this board."
    end
  end

  private

    def board_params
      params.require(:board).permit(:name, :description)
    end
end
