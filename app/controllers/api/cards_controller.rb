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
    render status: 403 if !current_user.manage_card?(@card)
    if @card.update(card_params)
      render json: @card
    else
      render json: @card.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    if current_user.manage_card?(@card)
      @card.destroy
      render status: 200, plain: 'Card successfully deleted.'
    else
      render status: 403, plain: "You haven't permission for delete this card."
    end
  end

  def move
    to_state = params[:to_state]
    if transition = @card.state_transitions
                         .find {|s| s.from == @card.state && s.to == to_state }
      @card.send transition.event
      render status: 200, plain: 'Card successfully moved'
    else
      render status: 400, plain: "Card can't be moved from #{@card.state} to " +
                                 to_state
    end
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
