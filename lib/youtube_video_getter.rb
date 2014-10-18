#require "nokogiri"
require "mechanize"

module YouTubeVideoGetter

  def self.query(search) # Returns array of ['video title', 'vidoecode11']
    Mechanize.new.
      tap { |i| i.follow_meta_refresh = true }.
      get("https://www.youtube.com/results?search_query=#{search.split(" ").join("+")}").
        links.
        select {|v| v.href["/watch?v="]}.
        delete_if {|v| v.text["\n"]}.
        map {|v| [v.text,v.href[(v.href.index("=")+1)..-1]]}
  end

  def self.vid_stats(video_code)
    
  end

end