class AddColsToScore < ActiveRecord::Migration[5.0]
  def change
    add_column :scores, :walk_score, :integer
    add_column :scores, :transit_score, :integer
  end
end
