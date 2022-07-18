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

ActiveRecord::Schema.define(version: 2022_07_18_193619) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "user_view_parties", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "view_party_id"
    t.boolean "host"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_view_parties_on_user_id"
    t.index ["view_party_id"], name: "index_user_view_parties_on_view_party_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
  end

  create_table "view_parties", force: :cascade do |t|
    t.integer "movie_api_id"
    t.integer "duration"
    t.date "date"
    t.time "time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "movie_image_path"
    t.string "movie_title"
    t.integer "host_id"
  end

  add_foreign_key "user_view_parties", "users"
  add_foreign_key "user_view_parties", "view_parties"
end
