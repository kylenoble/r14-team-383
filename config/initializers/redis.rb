if ENV["REDISGREEN_URL"]
  $redis = Redis.new(url: ENV["REDISGREEN_URL"], driver: :hiredis)
end