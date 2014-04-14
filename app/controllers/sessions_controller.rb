class SessionsController < ApplicationController
  def new
    return redirect_to user_path(current_user) if current_user

    client = GhostClient.oauth_client

    @authorize_url = client.auth_code.authorize_url(:redirect_uri => callback_session_url)
  end

  def callback
    client = GhostClient.oauth_client

    code = params[:code]

    if !current_user
      @access_token = client.auth_code.get_token(code, :redirect_uri => callback_session_url)

      session[:access_token] = @access_token.token

      @user = User.find_or_create_by_access_token(@access_token.token)
      user_fs = GhostClient.foursquare_client(@access_token.token)
      u = user_fs.user('self')

      if @user.foursquare_id.blank?
        @user.update_attributes(:firstname => u.firstName,
                                :lastname => u.lastName,
                                :foursquare_id => u.id,
                                :photo_prefix => u.photo.prefix,
                                :photo_suffix => u.photo.suffix)
        CheckinIngester.delay.ingest_latest_checkins_for_user_id(@user.id)

        flash[:success] = "Your primary Foursquare account has been used for authentication, and linked to Ghostme. Your checkins are importing in the background."
      else
        flash[:success] = "Welcome back to Ghostme."
      end
    else
      @user = current_user

      @secondary_access_token = client.auth_code.get_token(code, :redirect_uri => callback_session_url)

      @user.secondary_access_token = @secondary_access_token.token

      secondary_foursquare = Foursquare2::Client.new(:oauth_token => @secondary_access_token.token, :api_version => ENV['FOURSQUARE_API_VERSION'])

      @secondary_user = secondary_foursquare.user("self")

      @user.secondary_foursquare_id = @secondary_user.id

      @user.save
      flash[:success] = "Your secondary Foursquare account has been connected."
    end
    redirect_to root_path
  end


  def logout
    session[:access_token] = nil
    redirect_to "/"
  end
end
