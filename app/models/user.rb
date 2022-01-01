class User < ApplicationRecord
  validates_presence_of :name, :email

  extend FriendlyId
  friendly_id :name, use: :slugged

  has_secure_password
end
