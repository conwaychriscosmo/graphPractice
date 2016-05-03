class CreateDiceGames < ActiveRecord::Migration
  def change
    create_table :dice_games do |t|

      t.timestamps
    end
  end
end
