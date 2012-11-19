class PaymentDetail < ActiveRecord::Base
  attr_accessible :amount
  attr_protected  :payable_id, :payable_type, :user_id 
  
  belongs_to :payable, polymorphic: true
  belongs_to :user

  validates :amount, presence: true, numericality: {only_integer: true}
end
