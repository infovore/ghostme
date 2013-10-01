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

    if !@user.origin_location
      @user.origin_location = Location.new
    end
    @user.origin_location.update_from_string(params[:origin_location][:latlng_string])
    @user.origin_location.name = params[:origin_location][:name]

    if !@user.offset_location
      @user.offset_location = Location.new
    end
    @user.offset_location.update_from_string(params[:offset_location][:latlng_string])
    @user.offset_location.name = params[:offset_location][:name]
    @user.offset_location.time_offset = params[:offset_location][:time_offset]

    @user.save

    flash[:success] = "Details updated!"

    redirect_to profile_path
  end
end
