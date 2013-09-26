class ProfilesController < ApplicationController
  before_filter :require_user

  def show
    @user = current_user 
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.origin_name = params[:user][:origin_name]
    @user.update_origin_latlng_from_string(params[:user][:origin_latlng])
    @user.save
    redirect_to profile_path
  end
end
