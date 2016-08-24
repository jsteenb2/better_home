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

ActiveRecord::Schema.define(version: 20160824174422) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cities", force: :cascade do |t|
    t.string   "name",       null: false
    t.integer  "state_id",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "locations", force: :cascade do |t|
    t.integer  "house_num",       null: false
    t.string   "street",          null: false
    t.integer  "city_id",         null: false
    t.integer  "zip_id",          null: false
    t.integer  "neighborhood_id"
    t.string   "latitude"
    t.string   "longitude"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "states", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "abbr",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",          null: false
    t.integer  "age"
    t.string   "email",         null: false
    t.integer  "location_id"
    t.integer  "walk_score"
    t.integer  "transit_score"
    t.integer  "commute_score"
    t.integer  "cost_score"
    t.integer  "crime_score"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["email"], name: "index_users_on_email", using: :btree
  end

  create_table "zips", force: :cascade do |t|
    t.string   "zipcode",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["zipcode"], name: "index_zips_on_zipcode", using: :btree
  end

end
