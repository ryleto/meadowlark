class ArticlesController < ApplicationController
    before_action :logged_in_user, only: [:index, :show, :edit, :update, :destroy]
    
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
          redirect_to articles_path, notice: "Thank you. Your article has been posted."
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
          redirect_to articles_path, notice: "Article updated"
        else
          render 'edit'
        end
    end
    
    def destroy
        Article.find(params[:id]).destroy
        redirect_to articles_path, notice: "Article deleted"
    end
    
    private
    
        def article_params
          params.require(:article).permit(:pubdate, :title, :body, :source, :publish)
        end
end

    
    