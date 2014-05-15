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

ActiveRecord::Schema.define(:version => 20140227163505) do

  create_table "students", :force => true do |t|
    t.integer  "person_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "start_date"
    t.string   "end_date"
    t.string   "last_attend_date"
    t.string   "total_days"
    t.string   "days_attended"
    t.string   "total_days_minus_break"
    t.string   "total_attended_minus_break"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

end
