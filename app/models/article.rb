class Article < ActiveRecord::Base
    default_scope -> { order(pubdate: :desc) }
end
