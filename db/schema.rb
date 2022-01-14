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

ActiveRecord::Schema.define(version: 2022_01_14_155903) do

  create_table "changes", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "contact_id", null: false
    t.timestamp "date", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.string "name", limit: 45
    t.string "surname", limit: 45
    t.string "email", limit: 45
    t.string "tel", limit: 45
    t.index ["contact_id"], name: "index_changes_on_contact_id"
  end

  create_table "contacts", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", limit: 45, null: false
    t.string "surname", limit: 45, null: false
    t.string "email", limit: 45, null: false
    t.string "tel", limit: 45, null: false
  end

  add_foreign_key "changes", "contacts"
end
