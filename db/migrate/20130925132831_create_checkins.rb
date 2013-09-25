class CreateCheckins < ActiveRecord::Migration
  def change
    create_table :checkins do |t|
      t.string   "user_id"
      t.string   "checkin_id"
      t.string   "shout"
      t.integer  "timestamp",  :limit => 8
      t.string   "venue_id"
      t.string   "timezone"
      t.string   "venue_name"
      t.boolean  "reposted",   :default => false
      t.timestamps
    end
  end
end
