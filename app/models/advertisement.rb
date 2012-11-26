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

 # validate :check_advertisement_boards

 # private
 #   def check_advertisement_boards
 #	  if board.width <= (x_location + width)
 #	    errors.add(:x_location, ''
 #	end
end
