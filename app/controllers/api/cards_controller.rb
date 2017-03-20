class Api::CardsController < ApplicationController
  before_action :fetch_board, only: [:index, :create]

  def index
    render json: @board.cards
  end

  def create

  end

  def update

  end

  def destroy

  end

  def change_status

  end

  private

    def fetch_board
      @board = Board.find(params[:board_id])
    end
end
