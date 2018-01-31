class Message < ApplicationRecord
  belongs_to :player
  validates :content, presence: true
  validates :player_id, presence: true
  
  def self.most_recent
    order(:created_at).last(20)
  end
end