class CheckinIngestsController < ApplicationController
  before_filter :require_user

  def create
    start_count = current_user.checkins.size
    CheckinIngester.delay.ingest_latest_checkins_for_user_id(current_user.id)
    end_count = current_user.checkins.size
    diff_count = end_count - start_count

    #if diff_count > 0
      #flash[:success] = "#{diff_count} checkins ingested."
    #else
      #flash[:info] = "No new checkins ingested."
    #end
    #
    flash[:success] = "Your checkins are ingesting in the background. Reload this page shortly to see them."
    redirect_to checkins_path
  end

end
