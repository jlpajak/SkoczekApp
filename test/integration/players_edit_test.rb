require 'test_helper'

class PlayersEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @player = Player.create!(playername: "kuba", email: "kuba@example.com",
                          password: "password", password_confirmation: "password")
    @player2 = Player.create!(playername: "john", email: "john@example.com",
                    password: "password", password_confirmation: "password")
    @admin_user = Player.create!(playername: "john1", email: "john1@example.com",
                        password: "password", password_confirmation: "password", admin: true)
  end
  
  test "reject an invalid edit" do
    sign_in_as(@player, "password")
    get edit_player_path(@player)
    assert_template 'players/edit'
    patch player_path(@player), params: { player: { playername: " ", email: "kuba@example.com" } }
    assert_template 'players/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
  
  test "accept valid edit" do
    sign_in_as(@player, "password")
    get edit_player_path(@player)
    assert_template 'players/edit'
    patch player_path(@player), params: { player: { playername: "kuba1", email: "kuba1@example.com" } }
    assert_redirected_to @player
    assert_not flash.empty?
    @player.reload
    assert_match "kuba1", @player.playername
    assert_match "kuba1@example.com", @player.email
  end
  
  test "accept edit attempt by admin user" do
    sign_in_as(@admin_user, "password")
    get edit_player_path(@player)
    assert_template 'players/edit'
    patch player_path(@player), params: { player: { playername: "kuba3", email: "kuba3@example.com" } }
    assert_redirected_to @player
    assert_not flash.empty?
    @player.reload
    assert_match "kuba3", @player.playername
    assert_match "kuba3@example.com", @player.email
  end
  
  test "redirect edit attempt by another non-admin user" do
    sign_in_as(@player2, "password")
    updated_name = "joe"
    updated_email = "joe@example.com"
    patch player_path(@player), params: { player: { playername: updated_name, email: updated_email } }
    assert_redirected_to articles_path
    assert_not flash.empty?
    @player.reload
    assert_match "kuba", @player.playername
    assert_match "kuba@example.com", @player.email
  end 
  
end
