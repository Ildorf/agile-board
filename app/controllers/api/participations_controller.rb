class Api::ParticipationsController < ApplicationController
  before_action :authenticate_user!

  def create
    board = Board.find(params[:board_id])
    render status: 403 if !current_user.manage?(board)
    participation = board.participations.new(participation_params)
    if participation.save
      render json: participation.user
    else
      render json: participation.errors.full_messages,
             status: :unprocessable_entity
    end
  end

  def destroy
    participation = Participation.find(params[:id])
    if current_user.manage?(participation.board)
      participation.destroy
      render status: 200, plain: 'Participation successfully deleted.'
    else
      render status: 403, plain: "You haven't permission for delete this card."
    end
  end

  def update
    participation = Participation.find(params[:id])
    render status: 403 if !current_user.manage?(participation.board)
    if participation.update(role: participation_params[:role])
      render json: participation
    else
      render json: participations.errors.full_messages
    end
  end

  private

    def participation_params
      params.require(:participation).permit(:user_id, :role)
    end
end
