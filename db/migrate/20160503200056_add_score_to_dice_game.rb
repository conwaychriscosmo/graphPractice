class AddScoreToDiceGame < ActiveRecord::Migration
  def change
    add_column :dice_games, :score, :integer
  end
end
