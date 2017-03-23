class BoardsController < ApplicationController
  before_action :authenticate_user!

  def show
    @board = Board.includes(:users).find(params[:id])
  end

  def index
  end
end
