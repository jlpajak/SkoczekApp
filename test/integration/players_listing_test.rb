require 'test_helper'

class PlayersListingTest < ActionDispatch::IntegrationTest
  
  def setup
    @player = Player.create!(playername: "kuba", email: "kuba@example.com",
                    password: "password", password_confirmation: "password")
    @player2 = Player.create!(playername: "john", email: "john@example.com",
                    password: "password", password_confirmation: "password")
    @admin_user = Player.create!(playername: "john1", email: "john1@example.com",
                        password: "password", password_confirmation: "password", admin: true)  
  end
  
  test "should get players listing" do
    get players_path
    assert_template 'players/index'
    assert_select "a[href=?]", player_path(@player), text: @player.playername.capitalize
    assert_select "a[href=?]", player_path(@player2), text: @player2.playername.capitalize
  end
  
  test "should delete player" do
    sign_in_as(@admin_user, "password")
    get players_path
    assert_template 'players/index'
    assert_difference 'Player.count', -1 do
      delete player_path(@player2)
    end
    assert_redirected_to players_path
    assert_not flash.empty?
  end
  
end
