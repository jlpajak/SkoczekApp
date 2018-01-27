require 'test_helper'

class ArticlesTest < ActionDispatch::IntegrationTest
  
  def setup
    @player = Player.new(playername: "kuba", email: "kuba@example.com", password: "password", password_confirmation: "password")
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
    sign_in_as(@player, "password")
    get article_path(@article)
    assert_template 'articles/show'
    assert_match @article.name, response.body
    assert_match @article.description, response.body
    assert_match @player.playername, response.body
    assert_select 'a[href=?]', edit_article_path(@article), text: "Edit this article"
    assert_select 'a[href=?]', article_path(@article), text: "Delete this article"
    assert_select 'a[href=?]', articles_path, text: "Return to articles listing"
  end
  
  test "create new valid article" do
    sign_in_as(@player, "password")
    get new_article_path
    assert_template 'articles/new'
    name_of_article = "article"
    description_of_article = "awesome description"
    assert_difference 'Article.count', 1 do
      post articles_path, params: { article: { name: name_of_article, description: description_of_article}}
    end
    follow_redirect!
    assert_match name_of_article.capitalize, response.body
    assert_match description_of_article, response.body
  end
  
  test "reject invalid article submissions" do
    sign_in_as(@player, "password")
    get new_article_path
    assert_template 'articles/new'
    assert_no_difference 'Article.count' do
      post articles_path, params: { article: { name: " ", description: " " } }
    end
    assert_template 'articles/new'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
  
end