class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.string :username, null: false
      t.integer :games_played, null: false, default: 0
      t.integer :games_won, null: false, default: 0
      t.integer :games_draw, null: false, default: 0
    end
  end
end
