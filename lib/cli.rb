require 'terminal-table'
require './lib/messages'
require './lib/attendees_repository'
require './lib/container'

class CLI
  attr_reader :attendees, :queue, :con

  def initialize
    @attendees = AttendeesRepository.new
    @con = Container.new
  end

  def run
    command = gets.chomp.downcase.split(" ")
    process_command(command)
  end

  def process_command(command)
    return con.load_repository(command)     if command[0] == "load"
    return handle_help(command)             if command[0] == "help"
    return con.search(command)              if command[0] == "find"
    return handle_queue(command)            if command[0] == "queue"
    return con.subtract(command)            if command[0] == "subtract"
    return con.add(command)                 if command[0] == "add"
    return abort                            if command[0] == "quit"
    return Messages.invalid_command
  end

  def handle_queue(command)
    return con.handle_count                 if command       == ["queue", "count"]
    return con.queue_clear                  if command       == ["queue", "clear"]
    return con.queue_print                  if command       == ["queue", "print"]
    return con.queue_print_by(command[3])   if command[0..2] == ["queue", "print", "by"]
    return con.queue_district               if command       == ["queue", "district"]
    return con.queue_save_to(command[3])    if command[0..2] == ["queue", "save", "to"]
    return con.export_html(command[3])      if command[0..2] == ["queue", "export", "html"]
    return Messages.invalid_command
  end

  def handle_help(command)
    if command == ["help"]
      Messages.help
    elsif
      Messages.help_hash.keys.include?(command.join(" ").upcase)
      puts Messages.help_hash[command.join(" ").upcase]
    else
      Messages.invalid_command
    end
  end

  # def handle_load(command)
  #   @container.load_repository(command)
  # end
end
