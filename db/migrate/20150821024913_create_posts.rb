class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :entry
      t.string :author
      t.string :title
      t.integer :fuckyeahs
      t.text :topics

      t.timestamps
    end
  end
end
