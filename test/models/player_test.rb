require 'test_helper'

class PlayerTest < ActiveSupport::TestCase
  
  def setup
    @player = Player.new(playername: "kuba", email: "kuba@example.com")
  end
  
  test "should be valid" do
    assert @player.valid?
  end
  
  test "name should be present" do
    @player.playername = " "
    assert_not @player.valid?
  end
  
  test "name should be less than 30 characters" do
    @player.playername = "a" * 31
    assert_not @player.valid?
  end
  
  test "email should be present" do
    @player.email = " "
    assert_not @player.valid?
  end
  
  test "email should not be too long" do
    @player.email = "a" * 245 + "@example.com"
    assert_not @player.valid?
  end
  
  test "email should accept correct format" do
    valid_emails = %w[user@example.com KUBA@gmail.com M.first@yahoo.ca john+smith@co.uk.org]
    valid_emails.each do |valids|
      @player.email = valids
      assert @player.valid?, "#{valids.inspect} should be valid"
    end
  end
  
  test "should reject invalid addresses" do
    invalid_emails = %w[kuba@example kuba@example,com kuba.name@gmail. joe@bar+foo.com]
    invalid_emails.each do |invalids|
      @player.email = invalids
      assert_not @player.valid?, "#{invalids.inspect} should be invalid"
    end
  end 
  
  test "email should be unique and case insensitive" do
    duplicate_player = @player.dup
    duplicate_player.email = @player.email.upcase
    @player.save
    assert_not duplicate_player.valid?
  end
  
  test "email should be lower case before hitting db" do
    mixed_email = "JohN@ExampLe.com"
    @player.email = mixed_email
    @player.save
    assert_equal mixed_email.downcase, @player.reload.email 
  end
  
end