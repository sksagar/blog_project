class ChangeColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :articles_tags, :articles_id, :article_id
    rename_column :articles_tags, :tags_id, :tag_id
  end
end
