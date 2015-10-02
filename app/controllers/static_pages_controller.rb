class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @comment = current_user.comments.build if logged_in?
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def about
  end
  
  def contact
  end
  
  def news
  end
end
