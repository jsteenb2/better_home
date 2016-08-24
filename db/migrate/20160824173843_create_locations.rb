class CreateLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :locations do |t|
      t.integer :house_num, null: false
      t.string :street, null: false
      t.integer :city_id, null: false
      t.integer :zip_id, null: false
      t.integer :neighborhood_id
      t.string :latitude
      t.string :longitude

      t.timestamps
    end
  end
end
