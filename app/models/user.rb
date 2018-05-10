class User < ApplicationRecord
  attr_reader :password

  before_validation :ensure_session_token

  validates :email, :session_token, :password_digest, presence: true, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }
  
  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end


  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64
  end

  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save!
    self.session_token
  end

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end

  # def self.find_by_credentials(email, password)
  #   @user = User.find_by(email: email, password: password)
  # end
end
