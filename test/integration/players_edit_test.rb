require 'test_helper'

class PlayersEditTest < ActionDispatch::IntegrationTest
  
  def setup
   @player = Player.create!(playername: "kuba", 
                      email: "kuba@example.com",
                          password: "password", 
                          password_confirmation: "password")
  end
  
  test "reject an invalid edit" do
    get edit_player_path(@player)
    assert_template 'chefs/edit'
    patch player_path(@player), params: { player: { playername: " ", email: "mashrur@example.com" } }
    assert_template 'players/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
  
  test "accept valid edit" do
    get edit_player_path(@player)
    assert_template 'players/edit'
    patch player_path(@player), params: { player: { playername: "kuba1", email: "kuba1@example.com" } }
    assert_redirected_to @player
    assert_not flash.empty?
    @player.reload
    assert_match "kuba1", @player.playername
    assert_match "kuba1@example.com", @player.email
  end
  
end
