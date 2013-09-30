# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20130930155620) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "checkins", force: true do |t|
    t.string   "user_id"
    t.string   "checkin_id"
    t.string   "shout"
    t.integer  "timestamp",          limit: 8
    t.string   "venue_id"
    t.string   "timezone"
    t.string   "venue_name"
    t.boolean  "reposted",                     default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "lat"
    t.float    "lng"
    t.string   "category_id_list"
    t.string   "category_name_list"
  end

  create_table "locations", force: true do |t|
    t.string   "name"
    t.float    "lat"
    t.float    "lng"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "access_token"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "picture_url"
    t.string   "foursquare_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "origin_location_id"
    t.integer  "offset_location_id"
  end

  add_index "users", ["access_token"], name: "index_users_on_access_token", using: :btree

end
