# == Schema Information
#
# Table name: tiles
#
#  id               :integer          not null, primary key
#  advertisement_id :integer
#  x_location       :integer
#  y_location       :integer
#  cost             :decimal(, )
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  age              :integer
#  board_id         :integer
#

class Tile < ActiveRecord::Base
  attr_accessible :x_location, :y_location, :age
  attr_protected :advertisement_id, :cost, :board_id

  belongs_to :advertisement
  has_one :board, through: :advertisement

  validates :x_location, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0}
  validates :y_location, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0}
  validates :cost, presence: true, numericality: {greater_than_or_equal_to: 0}

  validate :check_tile_advertisement
  private
    
    def check_tile_advertisement
	  if x_location.is_a?(Integer) && y_location.is_a?(Integer)
		if x_location >= board.width || x_location < advertisement.x_location || x_location >= advertisement.x_location+advertisement.width
 	 	  errors.add(:x_location, 'tile x_location is not valid')
	    end

		if y_location >= board.height || y_location < advertisement.y_location || y_location >= advertisement.y_location+advertisement.height
		  errors.add(:y_location, 'tile y_location is not valid') 
		end
	  end
	end
end
