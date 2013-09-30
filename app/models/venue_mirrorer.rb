class VenueMirrorer
  def self.mirror_venue_for_checkin(checkin)
    # build a Foursquare object
    foursquare = Foursquare::Base.new(checkin.user.access_token)

    # get the relative latlng of this checkin
    # add them to the user's offset_latlng to get the search terms
    new_lat = checkin.user.offset_location.lat + checkin.relative_lat
    new_lng = checkin.user.offset_location.lng + checkin.relative_lng

    # search for venues near a space in the categories of this checkin
    venues = foursquare.venues.nearby(:ll => "#{new_lat}, #{new_lng}", :categoryId => checkin.category_id_list)

    # order them by proximity
    venues = venues.sort_by do |venue|
      lat_prox = (venue.location.lat - new_lat).abs
      lng_prox = (venue.location.lng - new_lng).abs
      lat_prox.abs + lng_prox.abs
    end

    # spit out the first one
    if venues.any?
      venues.first.json
    else
      nil
    end
  end
end
