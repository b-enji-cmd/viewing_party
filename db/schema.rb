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

ActiveRecord::Schema.define(version: 2021_04_01_025337) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "movies", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "api_id"
    t.integer "duration"
  end

  create_table "parties", force: :cascade do |t|
    t.bigint "movie_id"
    t.integer "duration"
    t.datetime "date"
    t.string "start_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.string "movie_title"
    t.integer "api_id"
    t.index ["movie_id"], name: "index_parties_on_movie_id"
    t.index ["user_id"], name: "index_parties_on_user_id"
  end

  create_table "user_friends", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "friend_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["friend_id"], name: "index_user_friends_on_friend_id"
    t.index ["user_id"], name: "index_user_friends_on_user_id"
  end

  create_table "user_parties", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "party_id"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["party_id"], name: "index_user_parties_on_party_id"
    t.index ["user_id"], name: "index_user_parties_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "parties", "movies"
  add_foreign_key "parties", "users"
  add_foreign_key "user_friends", "users"
  add_foreign_key "user_friends", "users", column: "friend_id"
  add_foreign_key "user_parties", "parties"
  add_foreign_key "user_parties", "users"
end
