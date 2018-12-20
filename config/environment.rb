require 'sqlite3'
require_relative '../lib/colors.rb'
# require_relative '../config/environment.rb'
require_relative '../lib/contact.rb'
require_relative '../lib/guide.rb'
#require_relative '../bin/call.rb'
# require 'pry'
# binding.pry


DB = {:conn => SQLite3::Database.new("../db/contact.db")}
