class AddOriginToUsers < ActiveRecord::Migration
  def change
    add_column :users, :origin_latitude, :float
    add_column :users, :origin_longitude, :float
  end
end
