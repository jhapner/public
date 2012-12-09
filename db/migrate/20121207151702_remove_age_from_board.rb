class RemoveAgeFromBoard < ActiveRecord::Migration
  def up
    remove_column :boards, :age
  end

  def down
    add_column :boards, :age, :integer
  end
end
