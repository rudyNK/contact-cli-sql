require_relative '../lib/contact'
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

  describe '#save' do
    it "insert into the contact table" do
        # Contact.save_contacts
       new_contact=Contact.new(name:"Gilbert",adress:"F rue 2",email:"gilbert@torchon.com",phone:3333)
       new_contact.save 

       sql="SELECT * FROM contact WHERE id=?"

       row= DB[:conn].execute(sql,new_contact.id)
       expect(row[0][0]).to eq(new_contact.id)
    
    end
  end

  # describe '::dropcontact(name)' do
  #   it "drops the contact table" do
  #       Contact.dropcontact(name)
 
  #     table_check_sql = "SELECT tbl_name FROM sqlite_master WHERE type='table' AND tbl_name='contact';"
  #     expect(DB[:conn].execute(table_check_sql)[0])
  #   end
  # end

  # describe '::update' do
  #   it "drops the contact table" do
  #       Contact.update
 
  #     table_check_sql = "SELECT tbl_name FROM sqlite_master WHERE type='table' AND tbl_name='contact';"
  #     expect(DB[:conn].execute(sql, self.name, self.adress, self.email, self.phone))
  #   end
  # end

  describe '::all' do
    it "list the contact table" do
        Contact.all
 
      table_check_sql = "SELECT tbl_name FROM sqlite_master WHERE type='table' AND tbl_name='contact';"
      expect(DB[:conn].execute(table_check_sql)[0])
    end
  end

  describe 'delete all' do
    it "deletes the contact table" do

      # new_contact=Contact.new(name:"Gilbert",adress:"F rue 2",email:"gilbert@torchon.com",phone:3333)
      #  new_contact.delete 
      Contact.delete

       sql="DELETE * FROM contact"

       row= DB[:conn].execute(sql)
        expect(row[0][0]).to eq(empty?)

      #   Contact.delete
 
      # table_check_sql = "SELECT tbl_name FROM sqlite_master WHERE type='table' AND tbl_name='contact';"
      # expect(DB[:conn].execute(table_check_sql)[0])
    end
  end
