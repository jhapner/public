class Board < ActiveRecord::Base
  attr_accessible :height, :name, :timezone, :width
  attr_protected :user_id
  has_many :tiles
  has_many :advertisements
  has_one :payment_detail, as: :payable
  belongs_to :user
  
  validates :width, presence: true, numericality: {only_integer: true, greater_than: 0}
  validates :height, presence: true, numericality: {only_integer: true, greater_than: 0}
  validates :name, presence: true
  validates :timezone, presence: true
end
