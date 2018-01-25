require 'test_helper'

class PlayersSignupTest < ActionDispatch::IntegrationTest
  
  test "should get signup path" do
    get signup_path
    assert_response :success
  end
  
  test "reject an invalid signup" do
    get signup_path
    assert_no_difference "Player.count" do
      post players_path, params: { player: { playername: " ", email: " ", password: "password", password_confirmation: " " } }
    end
    assert_template 'players/new'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
  
  test "accept valid signup" do
    get signup_path
    assert_difference "Player.count", 1 do
      post players_path, params: { player: { playername: "kuba", email: "kuba@example.com", password: "password", password_confirmation: "password" } }
    end
    follow_redirect!
    assert_template 'players/show'
    assert_not flash.empty?
  end
  
end
