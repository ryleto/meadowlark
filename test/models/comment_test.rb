require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  def setup
    @user = users(:rjleto)
    @comment = Comment.new(content: "some random comment", user_id: @user.id)
  end
  
  test "comment should be valid" do
    assert @comment.valid?
  end
  
  test "user ID should be present" do
    @comment.user_id = nil
    assert_not @comment.valid?
  end
  
  test "content should be present" do
    @comment.content = "   "
    assert_not @comment.valid?
  end

  test "content should be at most 140 characters" do
    @comment.content = "a" * 141
    assert_not @comment.valid?
  end

end
