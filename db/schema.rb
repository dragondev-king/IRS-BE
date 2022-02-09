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

ActiveRecord::Schema.define(version: 2022_02_08_095218) do

  create_table "filers", force: :cascade do |t|
    t.integer "ein"
    t.string "name"
    t.text "address"
    t.string "city"
    t.string "state"
    t.integer "zipcode"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "filings", force: :cascade do |t|
    t.integer "filer_id", null: false
    t.float "amount"
    t.string "purpose"
    t.integer "tax_period"
    t.integer "recipient_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["filer_id"], name: "index_filings_on_filer_id"
    t.index ["recipient_id"], name: "index_filings_on_recipient_id"
  end

  create_table "recipients", force: :cascade do |t|
    t.integer "ein"
    t.string "name"
    t.text "address"
    t.string "city"
    t.string "state"
    t.integer "zipcode"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "filings", "filers"
  add_foreign_key "filings", "recipients"
end
