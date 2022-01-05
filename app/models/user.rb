class User < ApplicationRecord
  validates :name, :email, :password, :password_confirmation, presence: true

  extend FriendlyId
  friendly_id :name, use: :slugged
  
  has_secure_password
end