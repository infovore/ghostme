class AddTimeOffsetToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :time_offset, :integer, :default => 0
  end
end
