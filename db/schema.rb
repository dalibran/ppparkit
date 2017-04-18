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

ActiveRecord::Schema.define(version: 20170418151147) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "park_its", force: :cascade do |t|
    t.integer  "points"
    t.string   "kind"
    t.datetime "paid_until"
    t.integer  "user_id"
    t.integer  "spot_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["spot_id"], name: "index_park_its_on_spot_id", using: :btree
    t.index ["user_id"], name: "index_park_its_on_user_id", using: :btree
  end

  create_table "spots", force: :cascade do |t|
    t.string   "place_no"
    t.decimal  "lat",              precision: 17, scale: 15
    t.decimal  "lng",              precision: 17, scale: 15
    t.string   "kind"
    t.integer  "bike_head"
    t.string   "pay_type"
    t.integer  "hour_rate"
    t.integer  "max_rate"
    t.string   "status"
    t.string   "bike_head_status"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.integer  "points"
    t.string   "photo"
    t.string   "avatar"
    t.string   "username"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

end
