class PagesController < ApplicationController
  def home
    client = OAuth2::Client.new(ENV['FOURSQUARE_CLIENT_ID'], ENV['FOURSQUARE_CLIENT_SECRET'], :site => 'https://foursquare.com', :authorize_url => '/oauth2/authorize')

    @authorize_url = client.auth_code.authorize_url(:redirect_uri => callback_session_url)
  end
end
