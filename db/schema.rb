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

ActiveRecord::Schema[7.0].define(version: 2023_11_29_061934) do
  create_table "admins", force: :cascade do |t|
    t.string "aid"
    t.string "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "carts", force: :cascade do |t|
    t.integer "user_id"
    t.integer "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.integer "product_id"
    t.string "key_word"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "majors", force: :cascade do |t|
    t.string "jid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "middles", force: :cascade do |t|
    t.string "did"
    t.integer "up_middle_id"
    t.integer "major_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "minors", force: :cascade do |t|
    t.string "nid"
    t.integer "middle_id"
    t.string "input_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "pid"
    t.integer "seller_id"
    t.integer "price"
    t.string "description"
    t.string "img"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "purchaseds", force: :cascade do |t|
    t.integer "user_id"
    t.integer "seller_id"
    t.integer "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sellers", force: :cascade do |t|
    t.string "sid"
    t.string "store_name"
    t.string "password"
    t.string "address"
    t.integer "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "uid"
    t.string "password"
    t.string "last_name"
    t.string "name"
    t.string "gender"
    t.string "address"
    t.integer "phone_number"
    t.date "birth"
    t.integer "profile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
