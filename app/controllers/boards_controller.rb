class BoardsController < ApplicationController
  before_filter :signed_in_user, 
              only: [:new]
  before_filter :signed_in, only: [:create]

  def index
  	@boards = Board.all
  end

  def show
	@board = Board.find(params[:id])
	@advertisements = @board.advertisements.paginate(page: params[:page], per_page: 1)
  end

  def new
	@board= Board.new
  end

  def create
	@board = current_user.boards.create(params[:board])
	@advertisement = @board.advertisements.build(params[:advertisement])
	@advertisement.user = current_user
	@advertisement.width = @board.width
	@advertisement.height = @board.height
    filename = Rails.root.join('spec', 'images', '3x5.jpg').to_s
	@advertisement.image_contents=File.open(filename)
	@advertisement.x_location = 0
	@advertisement.y_location = 0
	@payment_detail = @board.create_payment_detail
	@payment_detail.user = current_user
	if @board.save && @advertisement.save && @payment_detail.save
	  flash[:success] = "Board created!"
	  redirect_to @board
	else
	  render 'new'
	end
  end

  private

   	def signed_in
	  unless signed_in?
	    flash[:error] = "Not signed in"
        redirect_to root_path
	  end
    end	
end
