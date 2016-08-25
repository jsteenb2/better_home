class CreateScores < ActiveRecord::Migration[5.0]
  def change
    create_table :scores do |t|
      t.string :neighborhood
      t.index :neighborhood
      t.integer :eviction_score
      t.integer :fire_safety_score
      t.integer :crime_score
      t.integer :fire_incidents_score
      t.integer :traffic_score
      t.timestamps
    end
  end
end
