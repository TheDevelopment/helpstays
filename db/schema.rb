# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100605133504) do

  create_table "beds", :force => true do |t|
    t.integer "house_id"
  end

  create_table "beds_for_organisations", :force => true do |t|
    t.integer "organisation_type_id"
    t.integer "bed_id"
  end

  create_table "houses", :force => true do |t|
    t.integer "user_id"
    t.string  "address_1"
    t.string  "address_2"
    t.string  "country"
    t.string  "state"
    t.string  "post_code"
    t.string  "suburb"
    t.float   "lat"
    t.float   "long"
  end

  create_table "organisation_types", :force => true do |t|
    t.string "name"
  end

  create_table "organisations", :force => true do |t|
    t.integer "user_id"
    t.string  "name"
    t.integer "organisation_type_id"
    t.boolean "active",               :default => false
  end

  create_table "reservations", :force => true do |t|
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer  "bed_id"
    t.integer  "organisation_id"
  end

  create_table "roles", :force => true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.string   "activation_code",           :limit => 40
    t.datetime "activated_at"
    t.string   "state",                                    :default => "passive"
    t.datetime "deleted_at"
    t.string   "phone_number"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
