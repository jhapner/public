class AdvertisementsController < ApplicationController
  def new
	  @board = Board.find(params[:board_id])
	  @advertisement = Advertisement.new
  end

  def create
	  @board = Board.find(params[:board_id])
	  @advertisement = @board.advertisements.create(params[:advertisement])
	  @advertisement.user = current_user
	  if @advertisement.save
		flash[:success] = "Advertisement created"
		redirect_to @board
      else
	    render 'new'	   
	  end
  end

  def show
	  @advertisement = Advertisement.find(params[:id])
	  send_data(@advertisement.image)
  end
end
