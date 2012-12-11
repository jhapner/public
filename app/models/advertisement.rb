# == Schema Information
#
# Table name: advertisements
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  board_id   :integer
#  width      :integer
#  height     :integer
#  image      :binary
#  x_location :integer
#  y_location :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Advertisement < ActiveRecord::Base
  attr_accessible :height, :image, :width, :x_location, :y_location
  attr_protected :board_id, :user_id

  has_many :tiles
  has_many :payment_details, as: :payable
  belongs_to :user
  belongs_to :board

  validates :x_location, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0}
  validates :y_location, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0}
  validates :width, presence: true, numericality: {only_integer: true, greater_than: 0}
  validates :height, presence: true, numericality: {only_integer: true, greater_than: 0}
  validates :image, presence: true

  validate :check_advertisement_board

  before_create :initialize_advertisement
  after_create :charge

  def initialize_advertisement
	t = board.tiles
	if t.none?
      (x_location..x_location+(width-1)).each { |x| 
	    (y_location..y_location+(height-1)).each { |y|
		  t=tiles.build(x_location: x, y_location: y)
		  t.board_id = board_id
		  t.cost=0.0
		}
	  }
	else
      (x_location..x_location+(width-1)).each { |x| 
	    (y_location..y_location+(height-1)).each { |y|
		  t=Tile.find_by_board_id_and_x_location_and_y_location(board.id,x,y)
		  c = t.cost
		  t.destroy
		  t=tiles.build(x_location: x, y_location: y)
		  t.board_id = board_id
		  if c==0.0
		    t.cost=1.0
		  else
			t.cost=c*2
		  end
		}
	  }
	end
  end
  
  def image_contents=(file)
  	self.image=file.read
  end

  def charge
	if board.advertisements.count != 1
	  current_tiles = self.tiles
	  amount=0
	  (0..current_tiles.length-1).each { |t|
		amount+=current_tiles[t].cost
      }
	  payment_details.create(user: user, amount: amount)
	end
  end
  

  private
    
    def check_advertisement_board
	  if x_location.is_a?(Integer) && y_location.is_a?(Integer) && width.is_a?(Integer) && height.is_a?(Integer)
		if x_location+width > board.width
 	 	  errors.add(:x_location, 'Either ad width, x_location, or the combination is too large')
	    end

		if y_location+height > board.height
		  errors.add(:y_location, 'Either ad height, y_location, or the combination is too large') 
		end
	  end
	end
end
