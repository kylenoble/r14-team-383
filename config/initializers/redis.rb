if ENV["REDISCLOUD_URL"]
  $redis = Redis.connect(:url => ENV["REDISCLOUD_URL"])
end