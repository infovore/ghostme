class CheckinsController < ApplicationController
  before_filter :require_user

  def index
    @checkins = current_user.checkins.page(params[:page])
  end

  def show
    @checkin = current_user.checkins.find_by(:id => params[:id])
  end
end
