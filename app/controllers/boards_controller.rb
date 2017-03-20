class BoardsController < ApplicationController
  before_action :fetch_board, only: [:show, :edit, :update, :destroy]

  def new
    @board = Board.new
  end

  def create
    
  end

  def show
  end

  def index
    @boards = Board.all
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

    def fetch_board
      @board = Board.find(params[:id])
    end

    def board_params
      params.require(:board).permit(:name, :description)
    end
end
