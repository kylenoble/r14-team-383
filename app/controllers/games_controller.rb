class GamesController < ApplicationController


  # GET /games
  # GET /games.json
  def index
    search_term = params[:query]
  end

  def show
    @game = Game.first
    respond_to do |format|
      format.js {render 'sample'} # Change render when ready
      format.html {render 'show', object: :game, layout: nil} # Change render when ready
    end
  end

  def sample
    @game = Game.first
    @video = Video.where(game_id: @game.id).sort_by_quality.first
    @links = Link.all.take(8).shuffle
    render layout: nil
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def game_params
    params.require("game").permit(:id)
  end

end
