class AddCostToTiles < ActiveRecord::Migration
  def up
    add_column :tiles, :cost, :decimal, precision: 8, scale: 2
  end

  def down
	remove_column :tiles, :cost
  end
end
