class PagesController < ApplicationController
  def home
    client = GhostClient.oauth_client

    @authorize_url = client.auth_code.authorize_url(:redirect_uri => callback_session_url)
  end
end
