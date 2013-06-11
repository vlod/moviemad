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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130608213159) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "category_movies", :force => true do |t|
    t.integer  "category_id"
    t.integer  "movie_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "category_movies", ["category_id", "movie_id"], :name => "index_category_movies_on_category_id_and_movie_id"

  create_table "movie_details", :force => true do |t|
    t.integer  "movie_id"
    t.datetime "released_at"
    t.string   "runtime"
    t.string   "plot"
    t.string   "poster"
    t.string   "imdbID"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "movie_details", ["movie_id"], :name => "index_movie_details_on_movie_id"

  create_table "movies", :force => true do |t|
    t.string   "title"
    t.integer  "movielens_id"
    t.datetime "released_at"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "title_md5"
  end

  add_index "movies", ["movielens_id"], :name => "index_movies_on_movielens_id"
  add_index "movies", ["title_md5"], :name => "index_movies_on_title_md5"

end
