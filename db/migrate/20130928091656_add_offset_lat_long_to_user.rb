class AddOffsetLatLongToUser < ActiveRecord::Migration
  def change
    add_column :users, :offset_lat, :float
    add_column :users, :offset_lng, :float
    add_column :users, :offset_name, :string
  end
end
