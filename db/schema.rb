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

ActiveRecord::Schema.define(version: 20150521150756) do

  create_table "albums", force: :cascade do |t|
    t.integer  "film_id"
    t.integer  "user_id"
    t.integer  "person_id"
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "cover"
  end

  add_index "albums", ["film_id"], name: "index_albums_on_film_id"
  add_index "albums", ["person_id"], name: "index_albums_on_person_id"
  add_index "albums", ["user_id"], name: "index_albums_on_user_id"

  create_table "countries", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "films", force: :cascade do |t|
    t.string   "name"
    t.string   "origin_name"
    t.string   "slogan"
    t.integer  "country_id"
    t.integer  "genre_id"
    t.integer  "director_id"
    t.integer  "length"
    t.integer  "year"
    t.string   "trailer_url"
    t.string   "cover_file_name"
    t.string   "cover_content_type"
    t.integer  "cover_file_size"
    t.datetime "cover_updated_at"
    t.text     "description"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "films", ["country_id"], name: "index_films_on_country_id"
  add_index "films", ["director_id"], name: "index_films_on_director_id"
  add_index "films", ["genre_id"], name: "index_films_on_genre_id"

  create_table "films_people", id: false, force: :cascade do |t|
    t.integer "film_id",   null: false
    t.integer "person_id", null: false
  end

  add_index "films_people", ["film_id", "person_id"], name: "index_films_people_on_film_id_and_person_id"
  add_index "films_people", ["person_id", "film_id"], name: "index_films_people_on_person_id_and_film_id"

  create_table "genres", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "people", force: :cascade do |t|
    t.string   "name"
    t.string   "origin_name"
    t.date     "birthday"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "photos", force: :cascade do |t|
    t.integer  "album_id"
    t.string   "title"
    t.string   "object_file_name"
    t.string   "object_content_type"
    t.integer  "object_file_size"
    t.datetime "object_updated_at"
    t.integer  "position"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "photos", ["album_id"], name: "index_photos_on_album_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.integer  "role"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
