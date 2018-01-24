require 'test_helper'

class ArticlesDeleteTest < ActionDispatch::IntegrationTest
  
  def setup
    @player = Player.create!(playername: "kuba", email: "kuba@example.com")
    @article = Article.create(name: "some name", description: "some description", player: @player)
  end

  test "successfully delete a article" do
    get article_path(@article)
    assert_template 'articles/show'
    assert_select 'a[href=?]', article_path(@article), text: "Delete this article"
    assert_difference 'Article.count', -1 do
      delete article_path(@article)
    end
    assert_redirected_to articles_path
    assert_not flash.empty?
  end
  
end
