class AddTimezoneOffsetToCheckins < ActiveRecord::Migration
  def change
    add_column :checkins, :timezone_offset, :integer
    remove_column :checkins, :timezone, :string
  end
end
