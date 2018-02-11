require "celluloid"
require "redis"

class UserActivity
  include Celluloid

  REDIS_KEY = "rbot:user_activity"

  def initialize
    super
    @user_activity = {}
    @redis = Redis.new(url: ENV["REDISCLOUD_URL"])
  end

  def track(user_name:)
    now = Time.now.to_i
    last_ts = @user_activity.fetch(user_name, 0)
    @user_activity[user_name] = now

    @redis.hset(REDIS_KEY, user_name, now) if now - last_ts > 3600 # 1 hour
  end
end
