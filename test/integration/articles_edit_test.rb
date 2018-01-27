require 'test_helper'

class ArticlesEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @player = Player.new(playername: "kuba", email: "kuba@example.com", password: "password", password_confirmation: "password")
    @article = Article.create(name: "name", description: "description", player: @player)
  end

  test "reject invalid article update" do
    sign_in_as(@player, "password")
    get edit_article_path(@article)
    assert_template 'articles/edit'
    patch article_path(@article), params: { article: { name: " ", description: "some description" } } 
    assert_template 'articles/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
  
  test "successfully edit a article" do
    sign_in_as(@player, "password")
    get edit_article_path(@article)
    assert_template 'articles/edit'
    updated_name = "updated name"
    updated_description = "updated description"
    patch article_path(@article), params: { article: { name: updated_name, description: updated_description } }
    assert_redirected_to @article
    assert_not flash.empty?
    @article.reload
    assert_match updated_name, @article.name
    assert_match updated_description, @article.description
  end
  
end
