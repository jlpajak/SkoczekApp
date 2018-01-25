require 'test_helper'

class PlayersShowTest < ActionDispatch::IntegrationTest
  
  def setup
    @player = Player.create!(playername: "kuba", 
                        email: "kuba@example.com",
                        password: "password", 
                        password_confirmation: "password")
    @article = Article.create(name: "some name", description: "great description", player: @player)
    @article2 = @player.articles.build(name: "name beta", description: "greater description")
    @article2.save
  end
  
  test "should get players show" do
    get player_path(@player)
    assert_template 'players/show'
    assert_select "a[href=?]", article_path(@article), text: @article.name
    assert_select "a[href=?]", article_path(@article2), text: @article2.name
    assert_match @article.description, response.body
    assert_match @article2.description, response.body
    assert_match @player.playername, response.body
  end
  
end
