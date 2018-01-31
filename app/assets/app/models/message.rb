class Message < ApplicationRecord
  belongs_to :player
  validates :content, presence: true
  validates :player_id, presence: true
end