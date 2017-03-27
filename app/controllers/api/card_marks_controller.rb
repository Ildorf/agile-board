class Api::CardMarksController < ApplicationController
  before_action :authenticate_user!

  def create
    card_mark = current_user.card_marks.new(card_id: params[:card_id])
    if card_mark.save
      render json: card_mark.card
    else
      render json: card_mark.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    card_mark = CardMark.find(params[:id])
    if current_user.author?(card_mark)
      card = card_mark.card
      card_mark.destroy
      render json: card
    else
      render status: 403
    end
  end
end
