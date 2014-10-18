class YoutubeGetter
  extend HerokuResqueAutoScale::AutoScaling if Rails.env == "production"
  @queue = :youtube_getter_queue

  def defer(*args)
    Resque.enqueue(YoutubeGetter, self.id, *args)
  end

  def self.perform(game_id, *args)
    # Get game name from Game Object and
    # get a list results of videos for
    # game.  Create maybe 10 Video objects
    # in DB with Game as parent.
  end
end
