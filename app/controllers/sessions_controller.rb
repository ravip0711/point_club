class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      redirect_to user
    else
      flash.now[:danger] = "Invalid Email/Password"
      render "new"
    end
  end
end
