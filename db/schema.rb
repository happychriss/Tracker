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

ActiveRecord::Schema.define(:version => 20110116203937) do

  create_table "baselines", :force => true do |t|
    t.integer  "task_id"
    t.integer  "estimator_id",                                 :null => false
    t.string   "state",           :limit => 30
    t.text     "comment"
    t.text     "pm_comment"
    t.datetime "estimation_date"
    t.integer  "eac_hours",                     :default => 0
    t.float    "variance"
    t.integer  "pm_eac_amount",                 :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "budget_groups", :force => true do |t|
    t.string "group_name"
  end

  create_table "budget_types", :force => true do |t|
    t.integer  "budget_group_id", :null => false
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "budget_types_ressources", :id => false, :force => true do |t|
    t.integer "ressource_id",   :null => false
    t.integer "budget_type_id", :null => false
  end

  create_table "estimations", :force => true do |t|
    t.integer  "task_id"
    t.integer  "estimator_id",                                 :null => false
    t.integer  "baseline_id"
    t.integer  "etc_hours",                     :default => 0
    t.integer  "etc_amount",                    :default => 0
    t.string   "state",           :limit => 20
    t.text     "comment"
    t.date     "estimation_date"
    t.text     "pm_comment"
    t.integer  "eac_hours",                     :default => 0
    t.float    "variance"
    t.integer  "pm_eac_amount",                 :default => 0
    t.integer  "actual_hours",                  :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invitations", :force => true do |t|
    t.integer  "sender_id"
    t.string   "recipient_email"
    t.string   "token"
    t.datetime "sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "accepted_at"
  end

  create_table "organizations", :force => true do |t|
    t.string   "name",       :limit => 20
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "pm_id"
    t.integer  "organization_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "report_lines", :force => true do |t|
    t.integer "report_id"
    t.integer "budget_group_id"
    t.integer "position"
  end

  create_table "reports", :force => true do |t|
    t.string   "name"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ressources", :force => true do |t|
    t.decimal  "cost",       :precision => 11, :scale => 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "project_id"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "tasks", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.boolean  "status"
    t.date     "start"
    t.date     "stop"
    t.string   "estimation_type", :limit => 20
    t.string   "pm_contingency",  :limit => 20
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ressource_id"
    t.integer  "baseline_id"
    t.integer  "estimation_id"
  end

  create_table "users", :force => true do |t|
    t.integer  "organization_id",                      :null => false
    t.string   "username"
    t.boolean  "is_admin",          :default => false, :null => false
    t.string   "email"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.string   "perishable_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_pm",             :default => false, :null => false
    t.integer  "invitation_id"
    t.integer  "invitation_limit",  :default => 10
  end

  create_table "work_actuals", :force => true do |t|
    t.integer  "task_id"
    t.integer  "estimation_id"
    t.date     "start_date"
    t.integer  "duration"
    t.integer  "workhours"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "works", :force => true do |t|
    t.integer  "baseline_id"
    t.date     "start_date"
    t.integer  "duration"
    t.integer  "workhours"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "wp_actuals", :force => true do |t|
    t.integer  "wp_id"
    t.integer  "estimation_id"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "wps", :force => true do |t|
    t.integer  "baseline_id"
    t.integer  "p_estimate"
    t.integer  "m_estimate"
    t.integer  "o_estimate"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
