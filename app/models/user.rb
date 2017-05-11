class User < ApplicationRecord
  attr_accessor :password, :password_confirmation

  validates :first_name, :length => { maximum: 255 }, presence: true
  validates :last_name, :length => { maximum: 255 }, presence: true
  validates :email, uniqueness: true, :length => { maximum: 255 }, presence: true

  validates_with UserValidator

  has_many :subscriptions
  has_many :feeds, through: :subscriptions

  before_create do
    self.email = self.email.downcase
    self.encrypt_password!
    self.auth_token = self.class.generate_auth_token
  end

  def authenticate!(password)
    if correct_password?(password)
      new_auth_token = self.class.generate_auth_token
      update!(auth_token: new_auth_token)
      return new_auth_token
    else
      raise AuthenticationError, "Incorrect Password!"
    end
  end

protected

  def correct_password?(password)
    BCrypt::Password.new(self.encrypted_password) == password
  end

  def encrypt_password!
    self.encrypted_password = BCrypt::Password.create(self.password)
    self.password = nil
    self.password_confirmation = nil
  end

  def self.generate_auth_token
    SecureRandom.urlsafe_base64
  end

  class AuthenticationError < StandardError; end
end