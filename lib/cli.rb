require 'terminal-table'
require './lib/messages'
require './lib/attendees_repository'
require './lib/container'

class CLI
  attr_reader :attendees, :queue, :container,
              :messages

  def initialize
    @messages = Messages.new
    @attendees = AttendeesRepository.new
    @container = Container.new
  end

  def run
    command = gets.chomp.downcase.split(" ")
    process_command(command)
  end


  def process_command(command)
    return handle_load(command)       if command[0] == "load"
    return handle_help(command)       if command[0] == "help"
    return handle_find(command)       if command[0] == "find"
    return container.process(command) if command[0] == "queue"
    return abort                      if command[0] == "quit"
    return messages.invalid_command
  end

  def handle_load(command)
    messages.load_message
    command[1].nil? ? attendees.build_repository : attendees.build_repository(command[1])
  end

  def handle_help(command)
    return messages.help if command[1].nil?
    return messages.queue_count if command[1] == "queue" && command[2] == "count"
    return messages.queue_clear if command[1] == "queue" && command[2] == "clear"
  end

  def handle_find(command)
    criteria = command[2..4].join(" ")
    container.queue = container.queue | attendees.find(command[1], criteria)
  end

end
  private


#   def save_queue(criteria)
#     CSV.open(criteria, "wb") do |csv|
#       csv << queue
#     end
#   end
