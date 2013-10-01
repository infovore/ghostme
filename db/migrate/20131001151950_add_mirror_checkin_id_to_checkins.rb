class AddMirrorCheckinIdToCheckins < ActiveRecord::Migration
  def change
    add_column :checkins, :mirror_checkin_id, :string
  end
end
