class AddPlayerIdToArticles < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :player_id, :integer
  end
end
