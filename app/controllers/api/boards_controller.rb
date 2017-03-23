class Api::BoardsController < ApplicationController
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
      render status: :success
    else
      render status: :forbidden, message: "You haven't permission for delete "/
                                                                 "this board."
    end
  end

  private

    def board_params
      params.require(:board).permit(:name, :description)
    end
end
