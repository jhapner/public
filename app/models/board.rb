class Board < ActiveRecord::Base
  attr_accessible :height, :name, :timezone, :width
  attr_protected :user_id
  has_many :tiles
  has_many :advertisements
  has_one :payment_detail, as: :payable
  belongs_to :user
  
  validates :width, presence: true, numericality: {only_integer: true, greater_than: 0}
  validates :height, presence: true, numericality: {only_integer: true, greater_than: 0}
  validates :name, presence: true, length: {minimum:1}
  #http://stackoverflow.com/questions/12343124/how-to-validate-inclusion-of-time-zone
  validates :timezone, presence: true, inclusion: {in: ActiveSupport::TimeZone.zones_map(&:to_s)}
end
