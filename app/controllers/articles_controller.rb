class ArticlesController < ApplicationController
    before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
    
    def index
        @articles = Article.paginate(page: params[:page])
    end
    
    def show
        @article = Article.find(params[:id])
    end
    
    def new
        @article = Article.new
    end
    
    def create
        @article = Article.new(article_params)
        if @article.save
          flash[:info] = "Thank you. Your article has been posted."
          redirect_to @article
        else
          render 'new'
        end
    end
    
    def edit
        @article = Article.find(params[:id])
    end
    
    def update
        @article = Article.find(params[:id])
        if @article.update_attributes(article_params)
          flash[:success] = "Profile updated"
          redirect_to articles_path
        else
          render 'edit'
        end
    end
    
    def destroy
        Article.find(params[:id]).destroy
        flash[:success] = "Article deleted"
        redirect_to articles_path
    end
    
    private
    
        def article_params
          params.require(:user).permit(:pubdate, :title, :body, :source, :publish)
        end
end

    
    