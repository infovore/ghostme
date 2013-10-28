class Location < ActiveRecord::Base
  has_one :user

  def latlng_string
    "#{lat}, #{lng}"
  end

  def update_from_string(string)
    if string.strip != ""
      components = string.split(",")
      if components.size == 2
        lat,lng = string.split(",").map(&:strip)
        self.lat = lat
        self.lng = lng
      elsif components.size > 2
        raise "Too many components for a latlng."
      end
    end
  end
end
