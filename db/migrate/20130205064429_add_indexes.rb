class AddIndexes < ActiveRecord::Migration
  def up
    add_index :article_refs, :plos_id
    add_index :articles, :plos_id
  end

  def down
    remove_index :article_refs, :plos_id
    remove_index :articles, :plos_id
  end
end
