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

ActiveRecord::Schema.define(version: 20130705031755) do

  create_table "affiliations", force: true do |t|
    t.integer  "participant_id"
    t.integer  "chapter_id"
    t.integer  "recorded_attendance_count"
    t.integer  "recorded_host_count"
    t.date     "recorded_since"
    t.integer  "unrecorded_attendance_count"
    t.integer  "unrecorded_host_count"
    t.integer  "attendance_count"
    t.integer  "host_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "affiliations", ["chapter_id"], name: "index_affiliations_on_chapter_id"
  add_index "affiliations", ["participant_id"], name: "index_affiliations_on_participant_id"

  create_table "attendances", force: true do |t|
    t.integer  "participant_id"
    t.integer  "event_id"
    t.string   "tags"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "attendances", ["event_id"], name: "index_attendances_on_event_id"
  add_index "attendances", ["participant_id"], name: "index_attendances_on_participant_id"

  create_table "chapters", force: true do |t|
    t.string   "name"
    t.string   "location"
    t.string   "timezone"
    t.string   "url"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: true do |t|
    t.integer  "chapter_id"
    t.string   "name"
    t.datetime "start_time"
    t.datetime "end_time"
    t.text     "description"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "events", ["chapter_id"], name: "index_events_on_chapter_id"

  create_table "participants", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "alias"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", force: true do |t|
    t.string "name"
  end

end
