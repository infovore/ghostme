class MoveUserToLocationColumns < ActiveRecord::Migration
  def change
    remove_column :users, :origin_lat, :float
    remove_column :users, :origin_lng, :float
    remove_column :users, :origin_name, :string
    remove_column :users, :offset_lat, :float
    remove_column :users, :offset_lng, :float
    remove_column :users, :offset_name, :string
    add_column :users, :origin_location_id, :integer
    add_column :users, :offset_location_id, :integer
  end
end
