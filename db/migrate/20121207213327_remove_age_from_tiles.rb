class RemoveAgeFromTiles < ActiveRecord::Migration
  def up
    remove_column :tiles, :age
  end

  def down
    add_column :tiles, :age, :integer
  end
end
