class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :signed_in_user, except: [:index]
  before_action :correct_user,   only: [:edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in(@user)
      flash[:success] = "Welcome to the Point Club!"
      redirect_to users_path
    else
      render "new"
    end
  end

  def update
    if @user.update(user_params)
      redirect_to @user
    else
      render @user
    end
  end

  def destroy
    @user = User.find(params[:id]).destroy
    flash[:success] = "User Deleted"
    redirect_to users_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def signed_in_user
      unless signed_in?
        redirect_to login_url
      end
    end

     #confirms the correct user
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
