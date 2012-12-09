class PaymentDetailsController < ApplicationController
  #before_filter :find_payable
  def create
	@board = Board.find(params[:board_id])
	@payment_detail = @board.create_payment_detail(params[:payment_detail])
  end

  #private

 # def find_payable
#	@klass = params[:payable_type].capitalize.constantize
#	@payable = klass.find(params[:payable_id])
 # end
end
