class Article < ActiveRecord::Base
    default_scope -> { order(pubdate: :desc) }
    validates :pubdate, :title, :source, :presence => true
    validates :title, :source, :uniqueness => true
end
