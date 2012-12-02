class AddAgeToBoards < ActiveRecord::Migration
  def change
    add_column :boards, :age, :integer
  end
end
