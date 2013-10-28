class CheckinIngestsController < ApplicationController
  before_filter :require_user

  def create
    CheckinIngester.delay.ingest_latest_checkins_for_user_id(current_user.id)
    flash[:success] = "Your checkins are ingesting in the background. Reload this page shortly to see them."
    redirect_to checkins_path
  end

end
