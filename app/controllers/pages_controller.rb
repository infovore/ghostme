class PagesController < ApplicationController
  def home
    foursquare = Foursquare::Base.new(:client_id => ENV['FOURSQUARE_CLIENT_ID'], :client_secret => ENV['FOURSQUARE_CLIENT_SECRET'])
    @authorize_url = foursquare.authorize_url(callback_session_url)
  end
end
