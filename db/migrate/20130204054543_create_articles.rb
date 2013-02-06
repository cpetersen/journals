class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :plos_id
      t.text :xml
      t.text :error

      t.timestamps
    end
  end
end
