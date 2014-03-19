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

ActiveRecord::Schema.define(version: 20140318220017) do

  create_table "emails", force: true do |t|
    t.string   "subject"
    t.integer  "receiver"
    t.integer  "sender"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "listings", force: true do |t|
    t.string   "name"
    t.string   "category"
    t.string   "city"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo"
    t.text     "dates"
    t.string   "address"
  end

  create_table "messages", force: true do |t|
    t.string   "subject"
    t.integer  "receiver"
    t.integer  "sender"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reviews", force: true do |t|
    t.string   "title"
    t.string   "name"
    t.integer  "user_id"
    t.decimal  "rating"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "listing"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo"
    t.string   "email"
    t.string   "provider"
    t.string   "uid"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.text     "bio"
  end

end
