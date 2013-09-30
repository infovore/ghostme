class CheckinsController < ApplicationController
  before_filter :require_user
  before_filter :scope_to_user, :except => :index

  def index
    @checkins = current_user.checkins.order("timestamp desc").page(params[:page])
  end

  def show
  end

  def mirror
    respond_to do |format|
      format.json do 
        render :json => VenueMirrorer.mirror_venue_for_checkin(@checkin).to_json
      end
    end
  end

  private

  def scope_to_user
    @checkin = current_user.checkins.find_by(:id => params[:id])
  end
end
