class AddSecondaryFoursquareIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :secondary_foursquare_id, :string
  end
end
