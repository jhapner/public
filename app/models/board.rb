class Board < ActiveRecord::Base
  attr_accessible :height, :name, :timezone, :user_id, :width

  has_many :tiles
  has_many :advertisements
  has_one :payment_detail, as: :payable
  belongs_to :user
end
