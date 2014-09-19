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

ActiveRecord::Schema.define(version: 20140919141222) do

  create_table "leagues", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "matches", force: true do |t|
    t.integer "home_id"
    t.integer "away_id"
    t.integer "home_score"
    t.integer "away_score"
    t.date    "date"
    t.boolean "notified"
  end

  create_table "seasons", force: true do |t|
    t.integer "league_id"
    t.integer "team_id"
    t.integer "played"
    t.integer "won"
    t.integer "drawn"
    t.integer "lost"
    t.integer "goals_for"
    t.integer "goals_against"
    t.integer "goals_difference"
    t.integer "points"
  end

  create_table "subscriptions", force: true do |t|
    t.integer  "user_id"
    t.integer  "team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", force: true do |t|
    t.string "name"
    t.string "short_name"
  end

  create_table "users", force: true do |t|
    t.string   "gcm_regid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
