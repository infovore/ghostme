class AddScheduledToCheckins < ActiveRecord::Migration
  def change
    add_column :checkins, :scheduled, :boolean, :default => false
  end
end
