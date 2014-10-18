require "nokogiri"
require "mechanize"
require 'open-uri'
require 'addressable/uri'

module YtVid

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

  # https://developers.google.com/youtube/player_parameters
  # Recommended included options
  # {:embed => true, :autoplay => true, :origin => request.env["REQUEST_URI"]}

  def self.string_to_url(video_code, options = {})
    options.default = false
    parameters = "?"
    parameters.define_singleton_method(:ingest) {|item| self.<<("&") unless self[-1]["?"]; self.replace self.<<(item) }

    parameters.ingest("autoplay=1") if options[:autoplay]
    if options[:showplay]
      parameters.ingest("autohide=2")
    elsif options[:autohide]
      parameters.ingest("autohide=1")
    elsif options[:nohide]
      parameters.ingest("autohide=0")
    end
    parameters.ingest("cc_load_policy=1") if options[:cc]
    parameters.ingest("color=white") if options[:color] and !options[:modestbranding]
    parameters.ingest("controls=0") if options[:nocontrols]
    parameters.ingest("disablekb=1") if options[:nokeyboard]
    parameters.ingest("enablejsapi=1") if options[:jsapi]
    parameters.ingest("end=#{options[:end]}") if options[:end]
    parameters.ingest("fs=0") if options[:nofullscreen]
    # hl
    parameters.ingest("iv_load_policy=3") if options[:noanotate]
    # list
    # listType
    parameters.ingest("loop=1") if options[:loop]
    parameters.ingest("modestbranding=1") if options[:noytlogo]
    parameters.ingest("origin=#{CGI.escape(options[:origin])}") if options[:origin]
    # playerapiid
    # playlist
    parameters.ingest("playsinline=1") if options[:playinline]
    parameters.ingest("rel=0") if options[:norelated]
    parameters.ingest("showinfo=0") if options[:hideinfo]
    parameters.ingest("start=#{options[:start]}") if options[:start]
    parameters.ingest("theme=light") if options[:lighttheme]

    parameters=("") if parameters.length.==(1)

    if options[:short]
      "http://youtu.be/#{video_code}".<<(parameters).html_safe
    elsif options[:embed]
      "//www.youtube.com/embed/#{video_code}".<<(parameters).html_safe
    else
      "https://www.youtube.com/watch?v=#{video_code}".<<(parameters.gsub("?","&")).html_safe
    end
  end

end