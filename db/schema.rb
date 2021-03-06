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

ActiveRecord::Schema.define(version: 20160608042105) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.string   "author_type"
    t.integer  "author_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "dosage_responses", force: :cascade do |t|
    t.string   "dosage"
    t.string   "medicine"
    t.integer  "physician_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "patient_id"
    t.integer  "health_entry_id"
  end

  add_index "dosage_responses", ["health_entry_id"], name: "index_dosage_responses_on_health_entry_id", using: :btree
  add_index "dosage_responses", ["patient_id"], name: "index_dosage_responses_on_patient_id", using: :btree
  add_index "dosage_responses", ["physician_id"], name: "index_dosage_responses_on_physician_id", using: :btree

  create_table "health_entries", force: :cascade do |t|
    t.decimal  "weight",      precision: 5, scale: 2, null: false
    t.decimal  "bodyfat",     precision: 4, scale: 2, null: false
    t.decimal  "muscle_mass", precision: 5, scale: 2, null: false
    t.decimal  "heartrate",   precision: 3, scale: 1, null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "patient_id"
    t.string   "foreign_key"
    t.datetime "recorded_at"
  end

  add_index "health_entries", ["patient_id"], name: "index_health_entries_on_patient_id", using: :btree

  create_table "patients", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.integer  "age"
    t.string   "gender"
    t.text     "medical_history"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "phone_number"
    t.string   "withings_oauth_token"
    t.string   "withings_oauth_secret"
    t.string   "withings_user_id"
  end

  create_table "perscriptions", force: :cascade do |t|
    t.string   "medicine"
    t.string   "dosage"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "patient_id"
  end

  add_index "perscriptions", ["patient_id"], name: "index_perscriptions_on_patient_id", using: :btree

  create_table "physicians", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "phone"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
  end

  add_index "physicians", ["email"], name: "index_physicians_on_email", unique: true, using: :btree
  add_index "physicians", ["reset_password_token"], name: "index_physicians_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "dosage_responses", "health_entries"
  add_foreign_key "dosage_responses", "patients"
  add_foreign_key "dosage_responses", "physicians"
  add_foreign_key "health_entries", "patients"
  add_foreign_key "perscriptions", "patients"
end
