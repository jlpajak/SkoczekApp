require 'test_helper'

class ArticlesTest < ActionDispatch::IntegrationTest
  
  def setup
    @player = Player.create!(playername: "kuba", email: "kuba@example.com")
    @article = Article.create(name: "some name", description: "some description", player: @player)
    @article2 = @player.articles.build(name: "other name", description: "other description")
    @article2.save
  end
  
  test "should get articles index" do
    get articles_url
    assert_response :success
  end
  
  test "should get articles listing" do
    get articles_path
    assert_template 'articles/index'
    assert_match @article.name, response.body
    assert_match @article2.name, response.body
    assert_select "a[href=?]", article_path(@recipe), text: @article.name
    assert_select "a[href=?]", article_path(@recipe2), text: @article2.name
  end
  
  test "should get articles show" do
    get article_path(@article)
    assert_template 'articles/show'
    assert_match @article.name, response.body
    assert_match @article.description, response.body
    assert_match @player.playername, response.body
  end
  
  test "create new valid article" do
    get new_article_path
  end
  
  test "reject invalid article submissions" do
    get new_article_path
  end
  
end