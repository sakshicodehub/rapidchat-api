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

ActiveRecord::Schema[8.1].define(version: 2026_06_19_103048) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "blocked_users", force: :cascade do |t|
    t.bigint "blocked_user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["blocked_user_id"], name: "index_blocked_users_on_blocked_user_id"
    t.index ["user_id", "blocked_user_id"], name: "index_blocked_users_on_user_id_and_blocked_user_id", unique: true
    t.index ["user_id"], name: "index_blocked_users_on_user_id"
  end

  create_table "chat_members", force: :cascade do |t|
    t.bigint "chat_id", null: false
    t.datetime "created_at", null: false
    t.datetime "joined_at"
    t.datetime "left_at"
    t.integer "role", default: 0
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["chat_id", "user_id"], name: "index_chat_members_on_chat_id_and_user_id", unique: true
    t.index ["chat_id"], name: "index_chat_members_on_chat_id"
    t.index ["user_id"], name: "index_chat_members_on_user_id"
  end

  create_table "chats", force: :cascade do |t|
    t.string "avatar_url"
    t.integer "chat_type", default: 0, null: false
    t.datetime "created_at", null: false
    t.bigint "created_by_id", null: false
    t.text "description"
    t.string "name"
    t.datetime "updated_at", null: false
    t.index ["created_by_id"], name: "index_chats_on_created_by_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.bigint "contact_user_id", null: false
    t.datetime "created_at", null: false
    t.string "nickname"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["contact_user_id"], name: "index_contacts_on_contact_user_id"
    t.index ["user_id", "contact_user_id"], name: "index_contacts_on_user_id_and_contact_user_id", unique: true
    t.index ["user_id"], name: "index_contacts_on_user_id"
  end

  create_table "message_receipts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "delivered_at"
    t.bigint "message_id", null: false
    t.string "reaction"
    t.datetime "read_at"
    t.boolean "status", default: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["message_id"], name: "index_message_receipts_on_message_id"
    t.index ["user_id"], name: "index_message_receipts_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.string "attachment_url"
    t.bigint "chat_id", null: false
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "deleted_at"
    t.datetime "edited_at"
    t.integer "message_type", default: 0, null: false
    t.integer "reply_to_id"
    t.bigint "sender_id", null: false
    t.datetime "sent_at"
    t.datetime "updated_at", null: false
    t.index ["chat_id"], name: "index_messages_on_chat_id"
    t.index ["sender_id"], name: "index_messages_on_sender_id"
  end

  create_table "otp_verifications", force: :cascade do |t|
    t.integer "attempts", default: 0
    t.datetime "created_at", null: false
    t.datetime "expires_at"
    t.string "otp_digest", null: false
    t.string "phone", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.datetime "verified_at"
    t.index ["phone"], name: "index_otp_verifications_on_phone"
    t.index ["user_id"], name: "index_otp_verifications_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "about"
    t.string "avatar_url"
    t.datetime "created_at", null: false
    t.datetime "last_seen_at"
    t.string "name"
    t.boolean "online", default: false
    t.string "phone", null: false
    t.datetime "updated_at", null: false
    t.index ["phone"], name: "index_users_on_phone", unique: true
  end

  add_foreign_key "blocked_users", "users"
  add_foreign_key "blocked_users", "users", column: "blocked_user_id"
  add_foreign_key "chat_members", "chats"
  add_foreign_key "chat_members", "users"
  add_foreign_key "chats", "users", column: "created_by_id"
  add_foreign_key "contacts", "users"
  add_foreign_key "contacts", "users", column: "contact_user_id"
  add_foreign_key "message_receipts", "messages"
  add_foreign_key "message_receipts", "users"
  add_foreign_key "messages", "chats"
  add_foreign_key "messages", "users", column: "sender_id"
  add_foreign_key "otp_verifications", "users"
end
