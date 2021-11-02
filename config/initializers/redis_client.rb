if Rails.env.production?
  $redis_client = Redis.new(url: ENV["REDIS_URL"], ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE })
  $login_redis_client = Redis.new(url: ENV["REDIS_URL"], ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE }, db: 1)
  $email_redis_client = Redis.new(url: ENV["REDIS_URL"], ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE }, db: 2)
else
  $redis_client = Redis.new(host: 'localhost', port: 6379)
  $login_redis_client = Redis.new(host: 'localhost', port: 6379, db: 1)
  $email_redis_client = Redis.new(host: 'localhost', port: 6379, db: 2)
end