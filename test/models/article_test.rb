require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  
  def setup
    @player = Player.new(playername: "kuba", email: "kuba@example.com", password: "password", password_confirmation: "password")
    @player.save
    @article = @player.articles.build(name: "some name", description: "some description")  
  end
  
  test "article without player should be invalid" do
    @article.player_id = nil
    assert_not @article.valid?
  end
  
  test "article should be valid" do
    assert @article.valid?
  end  
  
  test "name should be present" do
    @article.name = " "
    assert_not @article.valid?
  end
  
  test "description should be present" do
    @article.description = " "
    assert_not @article.valid?
  end
  
  test "description shouldn't be less than 5 characters" do
    @article.description = "a" * 3
    assert_not @article.valid?
  end
  
end