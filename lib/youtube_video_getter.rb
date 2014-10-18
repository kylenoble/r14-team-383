require "nokogiri"
require "mechanize"
require 'open-uri'
require 'addressable/uri'

module YouTubeVideoGetter

  def self.query(search) # Returns array of ['video title', 'vidoecode11']
    Mechanize.new.
      tap { |i| i.follow_meta_refresh = true }.
      get("https://www.youtube.com/results?search_query=#{Addressable::URI.parse(search).normalize}").
        links.
        select {|v| v.href["/watch?v="]}.
        delete_if {|v| v.text["\n"]}.
        map {|v| [v.text,v.href[(v.href.index("=")+1)..-1]]}
  end

  def self.vid_stats(video_code)
    x = Nokogiri::HTML(open("https://www.youtube.com/watch?v=#{video_code}"))
    {
      video: video_code,
      views: Integer(x.css('div.watch-view-count').text.strip.gsub(",", "").<<("000")),
      likes: Integer(x.css('button#watch-like').text.strip.gsub(",", "").<<("000")),
      dislike: Integer(x.css('button#watch-dislike').text.strip.gsub(",", "").<<("000")),
      published: x.css('strong.watch-time-text').text[13..-1],
      license: x.css('li.watch-meta-item:nth-child(2)').text.gsub("\n", '').strip.tap {|i| i.replace i[i.index(" ")..-1].strip}
    }
  end

end