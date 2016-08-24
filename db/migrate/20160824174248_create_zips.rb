class CreateZips < ActiveRecord::Migration[5.0]
  def change
    create_table :zips do |t|
      t.string :zipcode

      t.timestamps
    end
  end
end
