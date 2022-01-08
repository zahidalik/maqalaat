class Thought < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: { maximum: 100 }
  validates :content, presence: true

  has_rich_text :content

  extend FriendlyId
  friendly_id :title, use: :slugged

  after_create_commit { broadcast_prepend_to("user_thoughts_list")}
end
