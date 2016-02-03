class PointsController < ApplicationController
  before_action :signed_in_user, only: [:new, :create]

  def new
    @point = Point.new
  end

  def create
    @point = Point.new(point_params)
    @point.user_id = current_user.id
    @point.save
    redirect_to points_path
  end

  def index
    @points = Point.all
  end

  def signed_in_user
    unless signed_in?
      redirect_to login_url
    end
  end

  private

  def point_params
    params.require(:point).permit(:points_given, :points_reason)
  end
end
