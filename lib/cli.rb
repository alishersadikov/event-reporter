require './lib/messages'
require './lib/attendees_repository'

class CLI
  attr_reader :printer, :load, :repository, :queue

  def initialize
    @messages = Messages.new
    @queue    = []
  end

  def start
    messages.welcome
  end

  def get_command_input
    messages.prompt_for_input
    input           = gets.chomp.downcase.split(" ")
    command         = input[0]
    option          = input[1]
    criteria        = input[2]
    case command
    when "load"
      message.load_message
      @repo = AttendeesRepository.new.build_repository('event_attendees.csv')
    when "help" then messages.help(input[1], input[2])
    when 'find' then validate_find_search(option, criteria)
    when 'queue' then queue_interaction(option, criteria)
    end
    get_user_command
  end

  def queue_interaction(option, criteria)
    case option
    when "count" then count_queue
    when "clear" then clear_queue
    when "save"  then save_queue(criteria)
    when "print" then print_queue
    end
  end

  private

  def count_queue
    p queue.flatten.count
  end

  def clear_queue
    @queue = []
  end

  def save_queue(criteria)
    CSV.open(criteria, "wb") do |csv|
      csv << queue
    end
  end

  def print_queue
    queue = @queue.flatten
    messages.table_header
    messages.format_attendee_table(queue)
  end

  def validate_find_search(option, criteria)
    if repository.nil?
      message.load_error_message
    elsif criteria.nil?
      message.help_instructions
    else
      @queue << repository.find_by(option, criteria)
    end
  end
end
