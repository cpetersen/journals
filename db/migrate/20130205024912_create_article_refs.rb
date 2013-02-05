class CreateArticleRefs < ActiveRecord::Migration
  def change
    create_table :article_refs do |t|
      t.integer :sequence
      t.string :plos_id
      t.string :plos_part
      t.text :xml
      t.text :error

      t.timestamps
    end
  end
end
