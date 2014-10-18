class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.integer :game_id 
      t.text :name
      t.text :video_code
      t.integer :renba_views
      t.integer :problem_reports
      t.text :license
      t.datetime :published_at
      t.integer :views 
      t.integer :likes
      t.integer :dislikes

      t.timestamps null: false
    end
    add_index :videos, :name 
    add_index :videos, :video_code
    add_index :videos, :created_at
    add_index :videos, :published_at
  end
end
