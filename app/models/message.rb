class Message < ApplicationRecord
  validates :content, presence: true
  after_create_commit { broadcast_append_to "messages" }
end
