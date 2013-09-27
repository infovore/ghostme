class AddLatLngToCheckins < ActiveRecord::Migration
  def change
    add_column :checkins, :lat, :float
    add_column :checkins, :lng, :float
  end
end
