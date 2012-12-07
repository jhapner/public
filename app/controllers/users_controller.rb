class UsersController < ApplicationController
  before_filter :signed_in_user, 
                only: [:show, :index, :edit, :update, :destroy]
  before_filter :correct_user,       only: [:show, :edit, :update]
  before_filter :admin_user,         only: [:index, :destroy]
  before_filter :non_signed_in_user, only: [:new, :create]
  
  def show
    @user = User.find(params[:id])
  end

  def new
	@user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the EBB App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def index
	@users = User.all
  end

  def destroy
	user=User.find(params[:id])
	if current_user != user
    	User.find(params[:id]).destroy
    	flash[:success] = "User destroyed."
       	redirect_to users_url
	else
		redirect_to(root_path)
	end
  end 
     
  private

    def correct_user
      @user = User.find(params[:id])
	  unless current_user?(@user)
	    flash[:error]="Wrong user"
	    redirect_to root_path
	  end
    end
    
	def admin_user
	  unless current_user.admin?
	    flash[:error]="Not an administrator"
        redirect_to root_path
	  end
    end
	
	def non_signed_in_user
	  redirect_to(root_path) unless !signed_in?
	end 
end
