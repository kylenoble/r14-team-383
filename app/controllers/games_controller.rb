class GamesController < ApplicationController
  before_action :set_game, only: [:show]

  # GET /games
  # GET /games.json
  def index
    search_term = params[:query]
  end

  def sample
    @game = Game.first
    @video = Video.where(game_id: @game.id).sort_by_quality.first || no_video_available
    @links = ["Link A", "Link B", "Link C", "Link D", "Link E", "Link F"]
    render layout: nil
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_game
    @game = Game.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def game_params
    params[:game]
  end

  def no_video_available
    "JN_xDdEY4Uk"
  end
end
