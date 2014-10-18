class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.text :game_type
      t.date :date
      t.text :home_team
      t.text :home_team_abv
      t.integer :home_score
      t.text :home_url
      t.text :home_players
      t.text :away_team
      t.text :away_team_abv
      t.integer :away_score
      t.text :away_url
      t.text :away_players

      t.timestamps null: false
    end
    add_index :games, :date
    add_index :games, :home_team
    add_index :games, :away_team
    add_index :games, :home_players
    add_index :games, :away_players
  end
end
