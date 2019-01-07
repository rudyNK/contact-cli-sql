# require_relative './config.rb'
require 'pry'
#The Guide class
class Guide
  class Config
    @@actions = ['list', 'find', 'add', 'delete', 'edit', 'exit']
    def self.actions; @@actions; end
  end

  def self.launch!
    Contact.create_table
    introduction
    menu
    # action loop
    result = nil
    until result == :exit
      action, args = get_action
      result = do_action(action, args)
    end
		#conclusion
  end
  
  def self.get_action
    action = nil
    # Keep asking for user input until we get a valid action
    until Guide::Config.actions.include?(action)
      puts "Actions: " + Guide::Config.actions.join(", ")
      print "\n> "
      user_response = gets.chomp
      args = user_response.downcase.strip.split(' ')
      action = args.shift
    end
    return action, args
  end
  
  def self.do_action(action, args=[])
    case action
    when 'list'
      Fi.output_action_header("Listing contact")
      if Contact.all.empty?
        puts "    OOPS, THERE'S NO CONTACT, ADD SOME!"
      else
      puts "----------------------------------------------------------------------" 
      puts "|ID |   FULL NAME    |   ADRESS    |  E-MAIL ADRESS   | PHONE NUMBER |"
      puts "----------------------------------------------------------------------"
      puts "    "
       Contact.all.each do |row|
        puts "| #{row.join " | " } |"
     end

    end
       puts "    "
    when 'find'
      find
    when 'add'
      add
    when 'delete'
     delete
    when 'edit'
      modify      
    when 'exit'
      conclusion
       exit
    else
      puts "\nI don't understand that command.\n"
    end
  end

  #The find methode
  def self.find(keyword="")
    Fi.output_action_header("Find a contact")
    name = gets.strip()
    # if Contact.find_by_name(name).empty?
    #   puts "THERE'S NO CONTACT WITH THIS NAME, ADD IT"
    # else
    res = Contact.find_by_name(name)
    # binding.pry
    if res.nil?
      puts "THERE'S NO CONTACT WITH THIS NAME, ADD IT"
    else
  puts "            "  
  puts "We found the following results:"
  puts "            "
  puts "  FULL NAME: #{res.name}\n  
  ADRESS: #{res.adress}\n
  PHONE NUMBER: #{res.phone}\n 
  E-MAIL ADRESS: #{res.email}\n"
    end
    puts "            " 
      puts "Find using a key phrase to search into the contact list."
      puts "Examples: ' Jean', ' Pierre', ' Carly'\n\n"
  end  

  #The add methode
  def self.add
    Fi.output_action_header("Add a contact")
     
    if Contact.build_using_questions
      puts "\nContact Added 😁\n\n"
    else
      puts "\nSave Error: Contact not added\n\n"
    end
  end

  def self.modify
    puts "            " 
    Fi.output_action_header("Editing contact")
# name = gets.strip()
# puts "    You're about to editing '#{name}' ?.\n"
# puts " Do you want to continue,'yes or no'?."
# print "> "
# answer = gets.strip().downcase
# if answer == "yes"
    Contact.build_using_questions2
# else 
#    launch!
# end
  end

  #The delete methode
  def self.delete
    puts Fi.output_action_header("Deleting contact")
    puts "1-Choose Contact to Delete"
    puts "2-Delete all"
    puts "3- Back to menu"
    puts "  "
    print "> "

answer = gets.strip().downcase
if answer == '1'
    Contact.deletecontact
elsif answer == '2'
  Contact.deleteall
elsif answer == '3'
  launch!
else
  puts "Invalide Command"
  end
end
 
  #The intro Game
  def self.introduction
    puts Fi.cool"\n\n      <<< Welcome to the contact list >>>    \n
    This is an interactive guide to help you.\n".upcase
  end

	def self.conclusion
  	puts Fi.cool"\n<<< Goodbye, See you Soon! >>>\n\n\n".upcase
  end
  

  # Go to the menu
  def self.menu
    Fi.output_action_header("--- MAIN MENU ---")
    
    puts "                      1- ADD A CONTACT"
    puts "                      2- CONTACT LIST"
    puts "                      3- FIND A CONTACT"
    puts "                      4- EDIT A CONTACT"
    puts "                      5- DELETE A CONTACT"
    puts "                      6- EXIT THE APP\n\n"
  end
  
  


	#private
	
	# def self.output_action_header(text)
	#   puts "\n#{text.upcase.center(60)}\n\n"
	# end
  
end

# Guide.launch!
