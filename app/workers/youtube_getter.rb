class YoutubeGetter
  extend HerokuResqueAutoScale::AutoScaling if Rails.env == "production"
  @queue = :youtube_getter_queue

  def defer(*args)
    Resque.enqueue(YoutubeGetter, self.id, *args)
  end

  def self.perform(game_id, *args)
    gathering_data = YtVid.
        query( search_string(game_id) ).
        sort_by {|hsh| hsh[:length].gsub(":","").to_i}.
        delete_if {|hsh| hsh[:description].=~(/NBA 2K1\d/i)}.
        delete_if {|hsh| hsh[:length].gsub(":","").to_i < 200}.
        take(grab_this_qty)

    gathering_data.each do |video_data|
      stats = YtVid.vid_stats(video_data[:video])
      next if stats[:description].=~(/NBA 2K1\d/i)
      next if stats[:category].=~(/gaming/i)
      next if stats[:username].=~(/Damien Prince/i)
      Video.new(
        game_id:              game_id,
        name:                 video_data[:title],
        video_code:           video_data[:video],
        views:                video_data[:views],
        new:                  video_data[:new],
        hd:                   video_data[:hd],
        highlights:           !!video_data[:title].=~(/highlights/i),
        description:          stats[:description],
        length:               video_data[:length],
        likes:                stats[:likes],
        dislikes:             stats[:dislikes],
        published_at:         stats[:published],
        license:              stats[:license]
      ).save
    end
  end

  private

  def self.search_string(game_id)
    game = Game.where(id: game_id).first
    output = ''
    output.concat( "#{game.game_type} " ) if game.game_type["playoffs"]
    output.concat( "\"#{game.home_team}\"" )
    output.concat( " vs " )
    output.concat( "\"#{game.away_team}\"" )
    output.concat( " #{game.date.strftime('%B %d, %Y')}" )
    output.concat( " -2K1 - Simulation")
  end

  def self.grab_this_qty
    12
  end

end
