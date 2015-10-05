require 'test_helper'

class CommentsInterfaceTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:rjleto)
  end

  test "comment interface" do
    log_in_as(@user)
    get root_path
    assert_select 'div.pagination'
    # Invalid submission
    assert_no_difference 'Comment.count' do
      post comments_path, comment: { content: "" }
    end
    assert_select 'div#error_explanation'
    # Valid submission
    content = "All streams flow to the sea because it is lower than they are.  Humility gives it its strength."
    assert_difference 'Comment.count', 1 do
      post comments_path, comment: { content: content }
    end
    assert_redirected_to root_url
    follow_redirect!
    assert_match content, response.body
    # Delete a post.
    assert_select 'a', text: 'delete'
    first_comment = @user.comments.paginate(page: 1).first
    assert_difference 'Comment.count', -1 do
      delete comment_path(first_comment)
    end
    # Visit a different user.
    get user_path(users(:meatsim))
    assert_select 'a', text: 'delete', count: 0
  end
end
