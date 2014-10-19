class YoutubeGetter
  extend HerokuResqueAutoScale::AutoScaling if Rails.env == "production"
  @queue = :youtube_getter_queue

  def defer(*args)
    Resque.enqueue(YoutubeGetter, self.id, *args)
  end

  def self.perform(game_id, *args)
    gathering_data = YtVid.
        query( search_string(game_id) ).
        take(grab_this_qty).
        sort_by {|hsh| hsh[:length].gsub(":","").to_i}.
        reverse.delete_if {|hsh| hsh[:length].gsub(":","").to_i < 200}
    gathering_data.each do |video_data|

      Video.new(

      )

    end
  end

  private

  def self.search_string(game_id)
    game = Game.where(game_id).first
    output = ''
    output.concat( "\"#{game.home_team}\"" )
    output.concat( " vs " )
    output.concat( "\"#{game.away_team}\"" )
    output.concat( " #{game.date.strftime('%B %d, %Y')}" )
  end

  def self.grab_this_qty
    8
  end
end
