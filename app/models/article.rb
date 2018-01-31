class Article < ApplicationRecord
  
  validates :name, presence: true
  validates :description, presence: true, length: { minimum: 5 }
  
  belongs_to :player
  
  validates :player_id, presence: true
  
  default_scope -> { order(updated_at: :desc) }
  has_many :article_tags
  has_many :tags, through: :article_tags
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  
  def thumbs_up_total
    self.likes.where(like: true).size
  end

  def thumbs_down_total
    self.likes.where(like: false).size    
  end
  
end