module Messages
  extend self

  def welcome
    puts "_______________________________________________________________\n\n"
    puts "--------------- WELCOME TO EVENT REPORTER !!! -----------------\n"
    puts "_______________________________________________________________\n\n"
    puts "ENTER COMMAND WHEN READY, OR TYPE 'HELP' FOR INSTRUCTIONS:"
  end

  def invalid_command
    puts "INVALID INPUT. TYPE 'HELP' FOR AVAILABLE COMMANDS OR TYPE COMMAND:"
  end

  def queue_empty
    puts "NO DATA TO DISPLAY: YOUR QUEUE IS NOT POPULATED!"
  end

  def load_message
    puts "THE REPOSITORY HAS LOADED AND IS READY TO USE !"
  end

  def queue_count(queue_count)
    puts "ENTRIES IN THE QUEUE: - #{queue_count} -"
  end

  def help
    puts "THE FOLLOWING COMMANDS ARE AVAILABLE:\n\n"

    commands = ["load <filename>",
                "find by <attribute> <criteria>",
                "queue count",
                "queue clear",
                "queue district",
                "queue print",
                "queue print by <attribute>",
                "queue save to <filename>",
                "queue export html <filename>",
                "subtract <attribute> <criteria>",
                "add <attribute> <criteria>",
                "find by <attribute> <criteria> and <attribute> <criteria>"]

    commands.each { |command|  puts "------ #{command.upcase}\n\n" }
    puts "------------------------- END OF LIST --------------------------\n"
  end

  def help_hash
    { "HELP LOAD" => "WILL LOAD THE REPOSITORY BASED ON THE GIVEN FILE OR THE DEFAULT FILE IF NOT SPECIFIED",
      "HELP FIND" => "SEARCHES THE REPOSITORY BY GIVEN ATTRIBUTE AND CRITERIA",
      "HELP QUEUE COUNT" => "OUTPUTS THE NUMBER OF RECORDS IN THE QUEUE",
      "HELP QUEUE CLEAR" => "EMPTIES THE QUEUE",
      "HELP QUEUE DISTRICT" => "IF ENTRIES ARE LESS THAN 10, WILL USE THE SUNLIGHT API TO GET CONGRESSIONAL DISTRICT NUMBERS",
      "HELP QUEUE PRINT" => "PRINTS THE QUEUE IN A TABLE WITH HEADERS",
      "HELP QUEUE PRINT BY" => "PRINTS THE SORTED QUEUE BY GIVEN ATTRIBUTE",
      "HELP QUEUE SAVE TO" => "SAVES THE QUEUE TO SPECIFIED FILE",
      "HELP QUEUE EXPORT HTML" => "EXPORTS THE QUEUE IN HTML FORMAT",
      "HELP SUBTRACT" => "REMOVES THE SPECIFIED ATTENDEE RECORDS FROM THE QUEUE",
      "HELP ADD" => "ADDS THE SPECIFIED ATTENDEE RECORDS TO THE QUEUE" }
  end
end
