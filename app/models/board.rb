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
#  age        :integer
#

class Board < ActiveRecord::Base
  attr_accessible :height, :name, :timezone, :width, :age
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
end
