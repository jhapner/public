class BoardsController < ApplicationController
  before_filter :signed_in_user, 
              only: [:new]
  before_filter :signed_in, only: [:create]

  def index
  	@boards = Board.all
  end

  def show
	@board = Board.find(params[:id])
	@advertisements = @board.advertisements.paginate(page: params[:page], per_page: 1, order: "created_at DESC")
  end

  def new
	@board= Board.new
  end

  def create
	@board = current_user.boards.build(params[:board])
	if @board.save
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
