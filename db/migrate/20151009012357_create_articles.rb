class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.integer :pubdate
      t.string :title
      t.text :body
      t.string :source
      t.integer :publish

      t.timestamps null: false
    end
  end
end
