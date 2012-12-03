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
