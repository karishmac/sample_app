class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user, only: :destroy
  
  def show
	@user = User.find(params[:id])
	@microposts = @user.microposts.paginate(page: params[:page])
  end
  
  def new
	@user = User.new
  end
  
  def create
	@user = User.new(params[:user])
	if @user.save
		sign_in @user
		flash[:success] = "Welcome to Sample App!"
		redirect_to @user 	#Handles a successful save.
	else
		render 'new'
	end
  end
  
  def edit
	#@user = User.find(params[:id])
  end
  
  def update
	@user = User.find(params[:id])
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
  
  def following
	@title = "Following"
	@user = User.find(params[:id])
	@users = @user.followed_users.paginate(page: params[:page])
	render 'show_follow'
  end
  
  def followers
	@title = "Followers"
	@user = User.find(params[:id])
	@users = @user.followers.paginate(page: params[:page])
	render 'show_follow'
  end
  
  private
  
  def signed_in_user
	unless signed_in?
		store_location
		redirect_to signin_path, notice: "Please sign in."
	end
	#redirect_to signin_path, notice: "Please sign in." unless signed_in?
  end
  
  def correct_user
	@user = User.find(params[:id])
	redirect_to(root_path) unless current_user?(@user)
  end
  
  def destroy
	User.find(params[:id]).destroy
	flash[:success] = "User destroyed."
	redirect_to users_path
  end
  
  def admin_user
	redirect_to(root_path) unless current_user.admin?
  end
  
end