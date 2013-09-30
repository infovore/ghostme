class MoveUserToLocationColumns < ActiveRecord::Migration
  def change
    remove_column :users, :origin_lat
    remove_column :users, :origin_lng
    remove_column :users, :origin_name
    remove_column :users, :offset_lat
    remove_column :users, :offset_lng
    remove_column :users, :offset_name
    add_column :users, :origin_location_id, :integer
    add_column :users, :offset_location_id, :integer
  end
end
