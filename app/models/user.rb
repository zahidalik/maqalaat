class User < ApplicationRecord
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
  validate :acceptable_avatar

  has_secure_password

  private

  def acceptable_avatar
    unless avatar.byte_size <= 500.kilobyte
      errors.add(:avatar, "should be less than 500 kilobytes")
    end

    acceptable_types = ["image/jpeg", "image/png"]
    unless acceptable_types.include?(avatar.content_type)
      errors.add(:avatar, "must be a JPEG or PNG")
    end
  end
end