class Like < ApplicationRecord
  belongs_to :player
  belongs_to :article
  
  validates_uniqueness_of :player, scope: :article
end