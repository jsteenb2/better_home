class CreateLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :locations do |t|
      t.integer :house_num
      t.string :street
      t.integer :city_id
      t.integer :zip_id
      t.integer :neighborhood_id

      t.timestamps
    end
  end
end
