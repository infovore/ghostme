class PagesController < ApplicationController
  def home
    foursquare = Foursquare::Base.new(ENV['FOURSQUARE_CLIENT_ID'], ENV['FOURSQUARE_CLIENT_SECRET'])
    @authorize_url = foursquare.authorize_url(callback_session_url)
  end
end
