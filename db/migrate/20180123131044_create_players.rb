class CreatePlayers < ActiveRecord::Migration[5.0]
  def change
    create_table :players do |t|
      t.string :playername
      t.string :email
      t.timestamps
    end
  end
end
