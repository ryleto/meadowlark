class StaticPagesController < ApplicationController
  def home
    @comment = current_user.comments.build if logged_in?
  end

  def about
  end
  
  def contact
  end
  
  def news
  end
end
