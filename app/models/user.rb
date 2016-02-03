class User < ActiveRecord::Base
  has_many :points
  
  attr_accessor :create_remember_token

  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 5 }

  has_secure_password


  # Returns the hash digest of the given string.
  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  # Generates a random token
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def create_remember_token
    self.remember_token = User.digest(User.new_remember_token)
  end

  def authenticated?(remember_token)
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
end
