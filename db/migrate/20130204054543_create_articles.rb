class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.integer :plos_id
      t.integer :sequence
      t.text :ref_xml
      t.text :article_xml
      t.text :error

      t.timestamps
    end
  end
end
