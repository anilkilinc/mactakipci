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

ActiveRecord::Schema.define(version: 20140910130935) do

  create_table "leagues", force: true do |t|
    t.string  "name"
    t.integer "team_count"
  end

  create_table "leagues_teams", id: false, force: true do |t|
    t.integer "team_id",          null: false
    t.integer "league_id",        null: false
    t.integer "played"
    t.integer "won"
    t.integer "drawn"
    t.integer "lost"
    t.integer "goals_for"
    t.integer "goals_against"
    t.integer "goals_difference"
    t.integer "points"
  end

  create_table "matches", force: true do |t|
    t.integer "league_id"
    t.integer "week_id"
    t.integer "home_id"
    t.integer "away_id"
    t.date    "date"
    t.string  "score"
    t.boolean "notified"
  end

  create_table "teams", force: true do |t|
    t.string "name"
    t.string "short_name"
  end

  create_table "teams_users", id: false, force: true do |t|
    t.integer "user_id", null: false
    t.integer "team_id", null: false
  end

  create_table "users", force: true do |t|
    t.string   "gcm_regid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
