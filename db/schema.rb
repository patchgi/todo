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

ActiveRecord::Schema.define(version: 20170319100955) do

  create_table "child_tasks", force: :cascade do |t|
    t.string   "name"
    t.string   "pid"
    t.integer  "check",      default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.text     "deadline"
    t.string   "p_name"
  end

  create_table "parent_tasks", force: :cascade do |t|
    t.string   "name"
    t.integer  "total_task",       default: 0
    t.integer  "completed_task",   default: 0
    t.integer  "check",            default: 0
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "user"
    t.string   "current_deadline", default: ""
    t.integer  "update_rank",      default: 0
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "password_digest"
    t.string   "image_url",       default: "http://www.warawareotoko.com/wp-content/uploads/2013/09/appbank.png"
    t.datetime "created_at",                                                                                      null: false
    t.datetime "updated_at",                                                                                      null: false
  end

end
