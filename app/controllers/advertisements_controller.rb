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
	    (1..@advertisement.height).each { |h| 
	  	  (1..@advertisement.width).each { |w|
		    @tile = @advertisement.tiles.create(params[:tile])
		    @tile.x_location = (w-1) + @advertisement.x_location
		    @tile.y_location = (h-1) + @advertisement.y_location
		    @tile.cost = 1
		    @tile.board_id = @board.id
			if !@tile.save
			  render 'new'
			end
		  }
	    }
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
