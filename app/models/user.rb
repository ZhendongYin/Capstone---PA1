class User < ApplicationRecord
  attr_accessor :remember_token

  has_secure_password
  before_save { self.email = email.downcase }
  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }

  has_many :enrollments
  has_many :courses, through: :enrollments

  def remember
    self.remember_token = SecureRandom.urlsafe_base64
    $login_redis_client.set(self.id, self.remember_token)
  end

  def authenticated?(_remember_token)
    remember_digest = $login_redis_client.get(self.id)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(_remember_token)
  end

  def forget
    $login_redis_client.del(self.id)
  end
end