class ChangeLatitudeToLatEtc < ActiveRecord::Migration
  def change
    rename_column :users, :origin_latitude, :origin_lat
    rename_column :users, :origin_longitude, :origin_lng
  end
end
