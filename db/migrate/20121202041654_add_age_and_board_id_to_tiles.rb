class AddAgeAndBoardIdToTiles < ActiveRecord::Migration
  def change
    add_column :tiles, :age, :integer
    add_column :tiles, :board_id, :integer
  end
end
