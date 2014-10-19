class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.integer :game_id, null: false
      t.text :name
      t.text :video_code
      t.integer :renba_views, null: false, default: 1
      t.integer :problem_reports, null: false, default: 1
      t.text :license
      t.datetime :published_at
      t.integer :views, null: false, default: 1
      t.integer :likes, null: false, default: 1
      t.integer :dislikes, null: false, default: 1
      t.boolean :new, null: false, default: false
      t.boolean :hd, null: false, default: false
      t.boolean :highlights, null: false, default: false
      t.text :description
      t.text :length
      t.timestamps null: false
    end
    add_index :videos, :name 
    add_index :videos, :video_code
    add_index :videos, :created_at
    add_index :videos, :published_at
  end
end
