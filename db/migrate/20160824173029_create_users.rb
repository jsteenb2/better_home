class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.integer :age
      t.string :email, unique: true, null: false, index: true
      t.integer :location_id
      t.integer :walk_score
      t.integer :transit_score
      t.integer :commute_score
      t.integer :cost_score
      t.integer :crime_score

      t.timestamps
    end
  end
end
