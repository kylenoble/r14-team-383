class GamesController < ApplicationController
  # GET /games
  # GET /games.json
  def index
    search_term = params[:query]
  end

  def view
    @game = Game.where(id: params["id"]).first
    @video = Video.where(game_id: @game.id).sort_by_quality.first
    @links = Link.all.take(8).shuffle
    respond_to do |format|
      format.js {render layout: nil}
      format.html {render layout: nil}
    end

  end

end
