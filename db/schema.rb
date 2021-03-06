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

ActiveRecord::Schema.define(version: 20151029001952) do

  create_table "keywords", force: :cascade do |t|
    t.text     "word"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "keywords_skills", id: false, force: :cascade do |t|
    t.integer "keyword_id",    null: false
    t.integer "skill_id",      null: false
    t.integer "raw_weighting"
  end

  add_index "keywords_skills", ["keyword_id", "skill_id"], name: "index_keywords_skills_on_keyword_id_and_skill_id"

  create_table "skills", force: :cascade do |t|
    t.text     "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

end
