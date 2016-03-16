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

ActiveRecord::Schema.define(version: 20160316022905) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "books", force: :cascade do |t|
    t.string   "title"
    t.string   "author"
    t.string   "isbn"
    t.string   "yearofpub"
    t.string   "image"
    t.string   "buylink"
    t.string   "description"
    t.string   "category"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "books_clubs", force: :cascade do |t|
    t.integer  "book_id"
    t.integer  "club_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "books_clubs", ["book_id"], name: "index_books_clubs_on_book_id", using: :btree
  add_index "books_clubs", ["club_id"], name: "index_books_clubs_on_club_id", using: :btree

  create_table "books_users", force: :cascade do |t|
    t.string   "category"
    t.integer  "book_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "books_users", ["book_id"], name: "index_books_users_on_book_id", using: :btree
  add_index "books_users", ["user_id"], name: "index_books_users_on_user_id", using: :btree

  create_table "bookstates", force: :cascade do |t|
    t.integer  "category"
    t.integer  "book_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "bookstates", ["book_id"], name: "index_bookstates_on_book_id", using: :btree
  add_index "bookstates", ["user_id"], name: "index_bookstates_on_user_id", using: :btree

  create_table "clubs", force: :cascade do |t|
    t.string   "name"
    t.string   "blurb"
    t.integer  "owner"
    t.boolean  "private"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clubs_users", force: :cascade do |t|
    t.integer  "club_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "clubs_users", ["club_id"], name: "index_clubs_users_on_club_id", using: :btree
  add_index "clubs_users", ["user_id"], name: "index_clubs_users_on_user_id", using: :btree

  create_table "comments", force: :cascade do |t|
    t.text     "content"
    t.integer  "author"
    t.integer  "topic_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "comments", ["topic_id"], name: "index_comments_on_topic_id", using: :btree

  create_table "topics", force: :cascade do |t|
    t.string   "title"
    t.integer  "author"
    t.integer  "book_id"
    t.integer  "club_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "count"
  end

  add_index "topics", ["book_id"], name: "index_topics_on_book_id", using: :btree
  add_index "topics", ["club_id"], name: "index_topics_on_club_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.text     "bio"
    t.string   "password_digest"
    t.string   "profilePic"
    t.string   "provider"
    t.string   "provider_id"
    t.string   "provider_hash"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "reset_code"
    t.datetime "expires_at"
  end

  add_foreign_key "books_clubs", "books"
  add_foreign_key "books_clubs", "clubs"
  add_foreign_key "books_users", "books"
  add_foreign_key "books_users", "users"
  add_foreign_key "bookstates", "books"
  add_foreign_key "bookstates", "users"
  add_foreign_key "clubs_users", "clubs"
  add_foreign_key "clubs_users", "users"
  add_foreign_key "comments", "topics"
  add_foreign_key "topics", "books"
  add_foreign_key "topics", "clubs"
end
