class Message < ApplicationRecord
  belongs_to :room
  validates :content, presence: true
  after_create_commit { broadcast_append_to room }
end
