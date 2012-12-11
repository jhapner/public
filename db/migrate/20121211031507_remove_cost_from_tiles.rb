class RemoveCostFromTiles < ActiveRecord::Migration
  def up
    remove_column :tiles, :cost
  end

  def down
    add_column :tiles, :cost, :decimal
  end
end
