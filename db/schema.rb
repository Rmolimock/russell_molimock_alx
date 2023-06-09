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

ActiveRecord::Schema[7.0].define(version: 2023_04_24_201744) do
  create_table "jokes", force: :cascade do |t|
    t.string "content"
    t.string "source"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "jokes_standup_sets", id: false, force: :cascade do |t|
    t.integer "joke_id", null: false
    t.integer "standup_set_id", null: false
    t.index ["standup_set_id", "joke_id"], name: "index_jokes_standup_sets_on_standup_set_id_and_joke_id", unique: true
  end

  create_table "standup_sets", force: :cascade do |t|
    t.integer "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
  end

end
