class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string   "access_token"
      t.string   "firstname"
      t.string   "lastname"
      t.string   "picture_url"
      t.string   "foursquare_id"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.timestamps
    end
    add_index :users, :access_token
  end
end
