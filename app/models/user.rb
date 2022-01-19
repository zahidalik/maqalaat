class User < ApplicationRecord
  attr_accessor :remember_token

  before_save { self.email = email.downcase }
  validates :name, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, allow_blank: true

  extend FriendlyId
  friendly_id :name, use: :slugged
  
  has_many :thoughts
  has_one_attached :avatar
  # validate :acceptable_avatar

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                 BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  has_secure_password

  # Returns a random token
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Returns true if the given token matches the digest.
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest) == (remember_token)
  end

  # Forgets a user
  def forget
    update_attribute(:remember_digest, nil)
  end

  # private

  # def acceptable_avatar
  #   # if avatar
  #   #   unless avatar.byte_size <= 500.kilobyte
  #   #     errors.add(:avatar, "should be less than 500 kilobytes")
  #   #   end
  #   # end
  #   acceptable_types = ["image/jpeg", "image/jpg", "image/png"]
  #   unless acceptable_types.include?(avatar.content_type)
  #     errors.add(:avatar, "must be a JPG, JPEG or PNG")
  #   end
  # end
end