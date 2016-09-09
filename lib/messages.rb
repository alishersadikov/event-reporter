class Messages

  def welcome
    puts "Welcome to Event Reporter!"
    puts "Enter your command when ready, or type 'help' for instructions:"
  end

  def invalid_command
    puts "Invalid input. Type your command again:"
  end

  def load_message
    puts "The repository has loaded."
  end

  def queue_count(queue_count)
    puts "--- #{queue_count} ---- entries in the queue"
  end

  def help
    puts "The following commands are available: \n'load'
'queue count'\n'queue clear'\n'queue district'\n'queue print'
'queue save'\nqueue print by attribute'\n'queue save to file'
'queue export html'\n'find by atribute and criteria'."
  end

  def help_queue_count
    puts "Outputs how many records are in the current queue."
  end

  def queue_clear
    puts "Empties the queue"
  end

  def queue_district
    puts "If there are less than 10 entries in the queue, this command will use the Sunlight API to get Congressional District information for each entry."
  end

  def queue_print
    puts "Print out a tab-delimited data table with a header row."
  end

  def find_success
    puts "The following data was found:"
  end

  def find_fail
    puts "No data found with given attribute and criteria."
  end

  def table_header

  end

  def format_attendee_table
  end

  def load_error_message
  end

  def help_instructions
  end

end
