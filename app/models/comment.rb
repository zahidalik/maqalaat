class Comment < ApplicationRecord
  belongs_to :thought

  validates_presence_of :content

  after_create_commit { broadcast_append_to("comments_list")}
end
