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

ActiveRecord::Schema.define(version: 20150409024258) do

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   limit: 4,     default: 0, null: false
    t.integer  "attempts",   limit: 4,     default: 0, null: false
    t.text     "handler",    limit: 65535,             null: false
    t.text     "last_error", limit: 65535
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by",  limit: 255
    t.string   "queue",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "housing_alerts", force: :cascade do |t|
    t.string  "name",           limit: 255
    t.integer "user_id",        limit: 4
    t.string  "location",       limit: 255
    t.string  "street_address", limit: 255
    t.string  "city",           limit: 50
    t.string  "province",       limit: 20
    t.string  "country",        limit: 20
    t.string  "postal_code",    limit: 6
    t.integer "kilometers",     limit: 4
    t.float   "latitude",       limit: 24
    t.float   "longitude",      limit: 24
  end

  add_index "housing_alerts", ["user_id"], name: "fk_rails_93c885998c", using: :btree

  create_table "housing_favorites", force: :cascade do |t|
    t.integer "housing_listing_id", limit: 4
    t.integer "user_id",            limit: 4
  end

  add_index "housing_favorites", ["housing_listing_id"], name: "fk_rails_0e6138bcc9", using: :btree
  add_index "housing_favorites", ["user_id"], name: "fk_rails_71a25d3c97", using: :btree

  create_table "housing_images", force: :cascade do |t|
    t.integer "housing_listing_id", limit: 4
    t.string  "url",                limit: 255
    t.string  "title",              limit: 255
    t.string  "description",        limit: 255
    t.string  "secure_url",         limit: 255
    t.string  "public_id",          limit: 255
  end

  create_table "housing_listings", force: :cascade do |t|
    t.string   "name",           limit: 255,                          null: false
    t.string   "description",    limit: 255
    t.string   "location",       limit: 255
    t.decimal  "price",                      precision: 12, scale: 2
    t.integer  "overall_rating", limit: 4
    t.integer  "price_rating",   limit: 4
    t.string   "postal_code",    limit: 6
    t.string   "city",           limit: 50
    t.string   "province",       limit: 20
    t.string   "country",        limit: 20
    t.float    "latitude",       limit: 24
    t.float    "longitude",      limit: 24
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",        limit: 4
    t.boolean  "active",         limit: 1
    t.string   "street_address", limit: 255
    t.datetime "deleted_at"
  end

  add_index "housing_listings", ["deleted_at"], name: "index_housing_listings_on_deleted_at", using: :btree
  add_index "housing_listings", ["latitude", "longitude"], name: "index_housing_listings_on_latitude_and_longitude", using: :btree

  create_table "housing_reviews", force: :cascade do |t|
    t.integer  "housing_listing_id", limit: 4
    t.integer  "user_id",            limit: 4
    t.string   "comment",            limit: 255
    t.integer  "rating",             limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "housing_settings", force: :cascade do |t|
    t.integer  "housing_listing_id", limit: 4
    t.string   "rental_type",        limit: 255
    t.datetime "start_date"
    t.datetime "end_date"
    t.boolean  "furnished",          limit: 1
    t.integer  "total_rooms",        limit: 4
    t.integer  "rooms_available",    limit: 4
    t.integer  "num_washrooms",      limit: 4
    t.boolean  "internet",           limit: 1,   default: false
    t.boolean  "parking",            limit: 1,   default: false
    t.boolean  "ensuite_washroom",   limit: 1,   default: false
    t.boolean  "washer_dryer",       limit: 1,   default: false
    t.boolean  "gym",                limit: 1,   default: false
    t.boolean  "pet_friendly",       limit: 1,   default: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "first_name",             limit: 255, default: "", null: false
    t.string   "last_name",              limit: 255, default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "housing_alerts", "users"
  add_foreign_key "housing_favorites", "housing_listings"
  add_foreign_key "housing_favorites", "users"
end
