class GamesController < ApplicationController


  # GET /games
  # GET /games.json
  def index
    search_term = params[:query]
  end

  def show
    @game = Game.where(id: params["id"]).first
    @video = Video.where(game_id: @game.id).sort_by_quality.first
    @links = Link.all.take(8).shuffle
    respond_to do |format|
      format.json { render json: {"game" => @game.as_json , "video" => @video.as_json, "links" => @links.as_json(only: [:name, :href])} }
      format.html { render json: {"game" => @game.as_json , "video" => @video.as_json, "links" => @links.as_json(only: [:name, :href])} }
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
