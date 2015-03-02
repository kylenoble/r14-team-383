class YoutubeGetter
  extend HerokuResqueAutoScale::AutoScaling if Rails.env == "production"
  @queue = :youtube_getter_queue

  def defer(*args)
    Resque.enqueue(YoutubeGetter, self.id, *args)
  end

  def self.perform(game_id, *args)
    gathering_data = YtUtil::Scrape.
        query( search_string(game_id) ).
        sort_by {|hsh| hsh[:length].gsub(":","").to_i}.
        delete_if {|hsh| hsh[:description].=~(/NBA 2K1\d/i)}.
        delete_if {|hsh| hsh[:length].gsub(":","").to_i < 200}.
        take(grab_this_qty)

    gathering_data.delete_if do |video_data|
      stats = YtUtil::Scrape.video_stats(video_data[:video])
      stats[:description].=~(/NBA 2K1\d/i) or
        stats[:category].=~(/gaming/i) or
        stats[:username].=~(/Damien Prince/i)
    end
  end

  private

  def self.search_string(qry)
    qry.concat( " -2K1 - Simulation")
  end

  def self.grab_this_qty
    12
  end

end
