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

ActiveRecord::Schema.define(version: 20150428175846) do

  create_table "attachments", force: true do |t|
    t.string   "filename"
    t.string   "content_type"
    t.binary   "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: true do |t|
    t.string   "name"
    t.integer  "contest_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["contest_id"], name: "index_categories_on_contest_id"

  create_table "comments", force: true do |t|
    t.integer "round_number"
    t.integer "project_id"
    t.integer "judge_id"
    t.string  "comment"
  end

  create_table "contests", force: true do |t|
    t.string   "name"
    t.string   "location"
    t.datetime "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", force: true do |t|
    t.string   "name"
    t.string   "location"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "contest_id"
  end

  create_table "projects_users", id: false, force: true do |t|
    t.integer "user_id",    null: false
    t.integer "project_id", null: false
  end

  create_table "question_types", force: true do |t|
    t.string  "question_type"
    t.integer "contest_id"
    t.integer "weight"
  end

  create_table "questions", force: true do |t|
    t.integer "question_type_id"
    t.string  "question"
    t.string  "comment"
  end

  create_table "scores", force: true do |t|
    t.integer "round_number"
    t.integer "project_id"
    t.integer "question_id"
    t.integer "judge_id"
    t.integer "score"
    t.string  "comment"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.boolean  "admin",                  default: false
    t.integer  "contest_id"
    t.integer  "category_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
