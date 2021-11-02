$redis_client = Redis.new(host: 'localhost', port: 6379)
$login_redis_client = Redis.new(host: 'localhost', port: 6379, db: 1)
$email_redis_client = Redis.new(host: 'localhost', port: 6379, db: 2)