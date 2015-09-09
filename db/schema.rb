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

ActiveRecord::Schema.define(version: 20150907074756) do

  create_table "expense_categories", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "user_id",     limit: 4
  end

  add_index "expense_categories", ["user_id"], name: "index_expense_categories_on_user_id", using: :btree

  create_table "income_categories", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "user_id",     limit: 4
  end

  add_index "income_categories", ["user_id"], name: "index_income_categories_on_user_id", using: :btree

  create_table "payment_methods", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "user_id",     limit: 4
  end

  add_index "payment_methods", ["user_id"], name: "index_payment_methods_on_user_id", using: :btree

  create_table "user_expenses", force: :cascade do |t|
    t.string   "amount",              limit: 255, default: "0"
    t.string   "description",         limit: 255
    t.date     "date"
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.integer  "user_id",             limit: 4
    t.integer  "expense_category_id", limit: 4
    t.integer  "payment_method_id",   limit: 4
  end

  add_index "user_expenses", ["expense_category_id"], name: "index_user_expenses_on_expense_category_id", using: :btree
  add_index "user_expenses", ["payment_method_id"], name: "index_user_expenses_on_payment_method_id", using: :btree
  add_index "user_expenses", ["user_id"], name: "index_user_expenses_on_user_id", using: :btree

  create_table "user_incomes", force: :cascade do |t|
    t.string   "amount",             limit: 255, default: "0"
    t.string   "description",        limit: 255
    t.date     "date"
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.integer  "user_id",            limit: 4
    t.integer  "income_category_id", limit: 4
    t.integer  "payment_method_id",  limit: 4
  end

  add_index "user_incomes", ["income_category_id"], name: "index_user_incomes_on_income_category_id", using: :btree
  add_index "user_incomes", ["payment_method_id"], name: "index_user_incomes_on_payment_method_id", using: :btree
  add_index "user_incomes", ["user_id"], name: "index_user_incomes_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",                   limit: 255
    t.string   "email",                  limit: 255, default: "", null: false
    t.boolean  "admin"
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "expense_categories", "users"
  add_foreign_key "income_categories", "users"
  add_foreign_key "payment_methods", "users"
  add_foreign_key "user_expenses", "expense_categories"
  add_foreign_key "user_expenses", "payment_methods"
  add_foreign_key "user_expenses", "users"
  add_foreign_key "user_incomes", "income_categories"
  add_foreign_key "user_incomes", "payment_methods"
  add_foreign_key "user_incomes", "users"
end
