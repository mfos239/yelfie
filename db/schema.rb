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

ActiveRecord::Schema.define(version: 20150330001528) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "businesses", force: true do |t|
    t.string   "name"
    t.string   "full_address"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "yelp_id"
    t.string   "yelp_url"
    t.string   "website_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photos", force: true do |t|
    t.integer  "yelper_id"
    t.integer  "review_id"
    t.string   "photo_url"
    t.string   "caption"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "photos", ["review_id"], name: "index_photos_on_review_id", using: :btree
  add_index "photos", ["yelper_id"], name: "index_photos_on_yelper_id", using: :btree

  create_table "reviews", force: true do |t|
    t.integer  "business_id"
    t.integer  "yelper_id"
    t.text     "review_content"
    t.string   "rating"
    t.datetime "review_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reviews", ["business_id"], name: "index_reviews_on_business_id", using: :btree
  add_index "reviews", ["yelper_id"], name: "index_reviews_on_yelper_id", using: :btree

  create_table "yelpers", force: true do |t|
    t.string   "name"
    t.string   "yelp_user_id"
    t.string   "photo_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
