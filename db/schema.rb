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

ActiveRecord::Schema[8.0].define(version: 2025_10_21_021407) do
  create_table "artists", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_artists_on_name", unique: true
  end

  create_table "comments", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "track_id", null: false
    t.text "body", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["track_id"], name: "index_comments_on_track_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "sample_segments", force: :cascade do |t|
    t.integer "sample_id", null: false
    t.integer "start_time", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sample_id"], name: "index_sample_segments_on_sample_id"
  end

  create_table "samples", force: :cascade do |t|
    t.integer "derived_track_id", null: false
    t.integer "source_track_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["derived_track_id", "source_track_id"], name: "index_samples_on_derived_track_id_and_source_track_id", unique: true
    t.index ["derived_track_id"], name: "index_samples_on_derived_track_id"
    t.index ["source_track_id"], name: "index_samples_on_source_track_id"
  end

  create_table "tracks", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "artist_id", null: false
    t.string "title", null: false
    t.integer "bpm"
    t.string "key"
    t.integer "year", null: false
    t.text "notes"
    t.string "video_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artist_id"], name: "index_tracks_on_artist_id"
    t.index ["title"], name: "index_tracks_on_title"
    t.index ["user_id"], name: "index_tracks_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "username", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest", null: false
    t.string "role", default: "user", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "comments", "tracks"
  add_foreign_key "comments", "users"
  add_foreign_key "sample_segments", "samples"
  add_foreign_key "samples", "tracks", column: "derived_track_id"
  add_foreign_key "samples", "tracks", column: "derived_track_id"
  add_foreign_key "samples", "tracks", column: "source_track_id"
  add_foreign_key "samples", "tracks", column: "source_track_id"
  add_foreign_key "tracks", "artists"
  add_foreign_key "tracks", "users"
end
