class Api::CardsController < ApplicationController
  before_action :fetch_board, except: [:update]
  before_action :fetch_card, only: [:update, :destroy, :move]
  before_action :authenticate_user!

  def index
    render json: @board.cards.eager_load(:user, :doer)
  end

  def create
    card = Card.new(card_params)
    card.user = current_user
    if card.save
      render json: card
    else
      render json: card.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    if @card.update(card_params)
      render json: @card
    else
      render json: @card.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    if current_user.author?(@card) || current_user.manage?(@board)
      @card.destroy
      render status: 200, json: ['Card successfully deleted.']
    else
      render status: :forbidden, json: ["You haven't permission for delete this card."]
    end
  end

  def move

  end

  private

    def fetch_board
      @board = Board.find(params[:board_id])
    end

    def fetch_card
      @card = Card.find(params[:id])
    end

    def card_params
      params.require(:card).permit(:title, :content, :doer_id)
            .merge(board_id: params[:board_id])
    end
end
