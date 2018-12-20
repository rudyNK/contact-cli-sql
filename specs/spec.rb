require_relative 'contact'
require 'sqlite3'
require 'pry'

#binding.pry

describe '::create_table' do
    it 'creates a contact table' do
     DB = {:conn => SQLite3::Database.new(":memory:")}
      DB[:conn].execute('DROP TABLE IF EXISTS contact')
      Contact.create_table
   
      table_check_sql = "SELECT tbl_name FROM sqlite_master WHERE type='table' AND tbl_name='contact';"
      expect(DB[:conn].execute(table_check_sql)[0]).to eq(['contact'])
    end
  end

  describe '::drop_table' do
    it "drops the contact table" do
        Contact.drop_table
 
      table_check_sql = "SELECT tbl_name FROM sqlite_master WHERE type='table' AND tbl_name='contact';"
      expect(DB[:conn].execute(table_check_sql)[0]).to be_nil
    end
  end

  describe '::save_contacts' do
    it "saves into the contact table" do
        Contact.save_contacts
 
      table_check_sql = "SELECT tbl_name FROM sqlite_master WHERE type='table' AND tbl_name='contact';"
      expect(DB[:conn].execute(table_check_sql)[0]).to eq 
    end
  end