# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_04_16_112258) do

  create_table "commits", force: :cascade do |t|
    t.string "sha"
    t.string "repo"
  end

  create_table "questions", force: :cascade do |t|
    t.string "title"
    t.string "repo"
  end

  create_table "users", force: :cascade do |t|
    t.string "uid"
    t.string "email"
    t.string "username"
    t.string "provider"
    t.string "token"
    t.string "repo"
    t.index ["uid"], name: "index_users_on_uid", unique: true
  end

end
