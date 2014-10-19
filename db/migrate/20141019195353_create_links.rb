class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.text :name
      t.text :href

      t.timestamps null: false
    end
  end
end
