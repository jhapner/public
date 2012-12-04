class BoardsController < ApplicationController
  before_filter :signed_in_user, 
              only: [:new]
  before_filter :signed_in, only: [:create]

  def index
  	@boards = Board.paginate(page: params[:page])
  end

  def show
	@board = Board.find(params[:id])
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
