class CreateData < ActiveRecord::Migration
  def change
    create_table :data do |t|
      t.string :one
      t.string :two
      t.string :three
      t.string :four
      t.string :five
      t.string :six

      t.timestamps
    end
  end
end
