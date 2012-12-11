# == Schema Information
#
# Table name: boards
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  name       :string(255)
#  width      :integer
#  height     :integer
#  timezone   :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Board < ActiveRecord::Base
  attr_accessible :height, :name, :timezone, :width
  attr_protected :user_id
  has_many :tiles, through: :advertisements
  has_many :advertisements
  has_one :payment_detail, as: :payable
  belongs_to :user
  
  validates :width, presence: true, numericality: {only_integer: true, greater_than: 0}
  validates :height, presence: true, numericality: {only_integer: true, greater_than: 0}
  validates :name, presence: true, length: {minimum:1}
  #http://stackoverflow.com/questions/12343124/how-to-validate-inclusion-of-time-zone
  validates :timezone, presence: true, inclusion: {in: ActiveSupport::TimeZone.zones_map(&:to_s)}

  before_create :board_initialize

  def age
	tiles.each do |t|
	  t.age
	end
	advertisements.each do |a|
	  a.charge
	end
  end
  
  def board_initialize
  	advertisement = advertisements.build(user: user, width: width, height: height, x_location: 0, y_location: 0)
    filename = Rails.root.join('spec', 'images', '3x5.jpg').to_s
	advertisement.image_contents=File.open(filename)
	create_payment_detail(user: user, amount: width*height) 
  end
end
