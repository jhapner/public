# == Schema Information
#
# Table name: payment_details
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  amount       :decimal(, )
#  payable_id   :integer
#  payable_type :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class PaymentDetail < ActiveRecord::Base
  attr_accessible :amount
  attr_protected  :payable_id, :payable_type, :user_id 
  
  belongs_to :payable, polymorphic: true
  belongs_to :user

  validates :amount, presence: true, numericality: true
end
