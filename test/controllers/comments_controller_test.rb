require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  def setup
    @comment = comments(:one)
  end
  
  test "should redirect create when not logged in" do
    assert_no_difference 'Comment.count' do
      delete :destroy, id: @comment
    end
    assert_redirected_to login_url
  end
  
  test "should redirect destroy for wrong comment" do
    log_in_as(users(:rjleto))
    comment = comments(:one)
    assert_no_difference 'Comment.count' do
      delete :destroy, id: comment
    end
    assert_redirected_to root_url
  end
end
