# require_relative './config.rb'

class Contact


    attr_accessor :name, :adress, :email, :phone
      attr_reader :id
      
      def initialize (id: nil , name:, adress:, email:, phone:)
          @id = id
          @name = name
          @adress = adress
          @phone = phone
      end
      
      def self.create_table
          sql = <<-SQL
          CREATE TABLE IF NOT EXISTS contact (
            id INTEGER PRIMARY KEY,
            name TEXT,
            adress TEXT,
            email TEXT,
            phone INTEGER
          )
          SQL
      
          DB[:conn].execute(sql)
      end
      
      def save
          sql = <<-SQL
            INSERT INTO contact (name, adress, email, phone) 
            VALUES (?, ?, ?, ?)
          SQL
      
          DB[:conn].execute(sql, self.name, self.adress, self.email, self.phone)
          @id = DB[:conn].execute("SELECT last_insert_rowid() FROM contact")[0][0]
          self
      end
      
      
        def self.new_from_db(row)
          
          Contact.new(id:row[0],name:row[1],adress:row[2],phone:row[3],email:row[4])
          # new_contact = self.new
          # new_contact.id = row[0]
          # new_contact.name =  row[1]
          # new_contact.adress = row[2]
          # new_contact.phone = row[3]
          # new_contact.email = row[4]
          # new_contact
        end
  
  def self.all
        sql = <<-SQL
          SELECT *
          FROM contact
        SQL
  
        DB[:conn].execute(sql)
  end
  
  def self.find_by_name(name)
    sql = <<-SQL
            SELECT *
            FROM contact
            WHERE name = ?
            LIMIT 1
          SQL
  
         raw_result= DB[:conn].execute(sql, name)[0]
         #binding.pry
         if raw_result.nil? 
          puts "  "
          else
         self.new_from_db(raw_result);
          end
  end
  
     def self.build_using_questions
      args = {}
      print "Contact name: "
      args[:name] = gets.chomp.strip
  
      print "Adress: "
      args[:adress] = gets.chomp.strip
      
      print "Phone Number: "
      args[:phone] = gets.chomp.strip
  
      print "E-Mail Adress: "
      args[:email] = gets.chomp.strip
      
      c = self.new(**args)
  
      #create_file(name:, adress:, email:, phone:)
      c.save
  
    end
  
    def drop_all
      sql = "DROP TABLE IF EXISTS contacts"
      DB[:conn].execute(sql)
  
  end

  def self.deleteall
    sql = "DELETE FROM contact"
  DB[:conn].execute(sql)[0]
  puts "            " 
  puts "All your contacts has been deleted 👍\n\n"
  end
  
  
  def self.dropcontact(name)
  sql = "DELETE FROM contact WHERE(name) = ?;"
  DB[:conn].execute(sql,name)[0]
 
  
  end
  
  def self.deletecontact
  # puts "Your Contacts:".upcase
  # all.each {|m|
  #     m.printKontak
    
  # }
  puts "            " 
  puts "type the name of the contact to delete"
  print "> "
  name = gets.strip()
  puts "You're  deleting '#{name}' ?"
  puts "Are you sure, Yes or No?."
  print "> "
  answer = gets.strip().downcase
  if answer == "yes"
      #d = deletecontact.new
      dropcontact(name)
       puts "            " 
  puts "contact deleted 👍"
  else 
     Guide.launch!
  end
  end
  
    
    def initialize(args={})
      @name    = args[:name]    || ""
      @adress = args[:adress] || ""
      @phone   = args[:phone]   || ""
      @email   = args[:email]   || ""
    end
  
    def update
      sql = "UPDATE contact SET adress = ?, phone = ?, email = ? WHERE name = ?"
      DB[:conn].execute(sql, self.name, self.adress, self.email, self.phone)
    end

 
  
    def self.build_using_questions2
      puts "enter the name you whish to alter!"
      name = gets.strip()

      all.each do |row|
      
        
       if name == row[1]
          puts "    You're about to editing '#{name}' ?.\n"
          puts " Do you want to continue,'yes or no'?."
          print "> "
          answer = gets.strip().downcase
          if answer == "yes"
        args = {}
        puts " "
        print "Contact name: "
        args[:name] = gets.chomp.strip
  
        print "Adress: "
        args[:adress] = gets.chomp.strip
      
        print "Phone Number: "
        args[:phone] = gets.chomp.strip
        
        print "E-Mail Adress: "
        args[:email] = gets.chomp.strip
      
        c = new(args)
        
        c.update
        c.save
        dropcontact(name)
        #create_file(name:, adress:, email:, phone:)
        puts "   "
        puts "Contact Updated!👍\n "
          end
      end
    end
    end
    
    def import_line(line)
      line_array = line.split("\t")
      @name, adress, @phone, @email = line_array
      return self
    end
   
    
    def self.alphabetic_order
     sql = "SELECT * FROM contacts ORDER BY name ASC"
     DB[:conn].execute(sql)
   end
    
    
  end
  
  # Contact.build_using_questions
  
  