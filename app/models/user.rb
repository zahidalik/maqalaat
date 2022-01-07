class User < ApplicationRecord
  before_save { self.email = email.downcase }
  validates :name, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
  validates :username, presence: true, uniqueness: true, length: { minimum: 4 }

  extend FriendlyId
  friendly_id :name, use: :slugged
  
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_blank: true
end