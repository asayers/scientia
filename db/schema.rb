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

ActiveRecord::Schema.define(:version => 20121124011310) do

  create_table "documents", :force => true do |t|
    t.string   "name"
    t.string   "slug"
    t.integer  "user_id"
    t.integer  "template_id"
    t.text     "body"
    t.text     "warnings"
    t.boolean  "public"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "documents", ["slug"], :name => "index_documents_on_slug"
  add_index "documents", ["template_id"], :name => "index_documents_on_template_id"
  add_index "documents", ["user_id"], :name => "index_documents_on_user_id"

  create_table "favourites", :force => true do |t|
    t.string   "name"
    t.string   "slug"
    t.string   "type"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "favourites", ["slug"], :name => "index_favourites_on_slug"
  add_index "favourites", ["user_id"], :name => "index_favourites_on_user_id"

  create_table "supplements", :force => true do |t|
    t.string   "name"
    t.string   "type"
    t.integer  "document_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "supplements", ["document_id"], :name => "index_supplements_on_document_id"

  create_table "templates", :force => true do |t|
    t.string   "name"
    t.string   "slug"
    t.integer  "user_id"
    t.text     "body"
    t.text     "warnings"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "templates", ["slug"], :name => "index_templates_on_slug"
  add_index "templates", ["user_id"], :name => "index_templates_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "username",         :null => false
    t.string   "email"
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

end
