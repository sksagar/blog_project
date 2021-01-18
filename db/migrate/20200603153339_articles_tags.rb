class ArticlesTags < ActiveRecord::Migration[5.2]
  def change
    create_table :articles_tags do |t|
      t.integer :articles_id
      t.integer :tags_id

      t.timestamps
    end
  end
end
