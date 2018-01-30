require 'test_helper'

class PlayersLoginTest < ActionDispatch::IntegrationTest
  
  def setup
    @player = Player.create!(playername: "kuba", email: "kuba@example.com", password: "password")
  end
  
  test "invalid login is rejected" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: " ", password: " " } }
    assert_template 'sessions/new'
    assert_not flash.empty?
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path, count: 0
    get root_path
    assert flash.empty?
  end
  
  test "valid login credentials accepted and begin session" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: @player.email, password: @player.password } }
    assert_redirected_to @player
    follow_redirect!
    assert_template 'players/show'
    assert_not flash.empty?
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", player_path(@player)
    assert_select "a[href=?]", edit_player_path(@player)
  end
  
end
