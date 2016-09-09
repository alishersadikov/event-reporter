require 'terminal-table'
require './lib/Messages'
require './lib/html_exporter'
require './lib/attendee_data'
require './lib/attendees_repository'

class Container
  attr_accessor :queue, :attendees
  HEADER_ROW = ["LAST NAME","FIRST NAME","EMAIL","ZIPCODE","CITY","STATE","ADDRESS","PHONE","DISTRICT"]

  def initialize
    @queue = []
    @attendees = AttendeesRepository.new
  end

  def load_repository(command)
    Messages.load_message
    command[1].nil? ? attendees.build_repository : attendees.build_repository(command[1])
  end

  def queue_clear
    @queue = []
  end

  def handle_count
    Messages.queue_count(queue.count)
    queue.count
  end

  def search(command)
    case command.include? "and"
    when false
      queue_clear
      criteria = command[2..4].join(" ")
      @queue = attendees.find(attendees.repo, command[1], criteria)
    else
      improved_find(command)
    end
  end

  def improved_find(command)
    separated = command.join(" ").split("and")
    set_1 = separated[0].split[-2..-1]
    set_2 = separated[1].split
    @queue = attendees.find(attendees.repo, set_1[0], set_1[1])
    @queue = attendees.find(@queue, set_2[0], set_2[1])
  end


  def queue_print
    case @queue.empty?
    when true
      Messages.queue_empty
    else
      rows = @queue.map { |attendee|  AttendeeData.data_from_attendee(attendee) }
      print_terminal_table(rows)
      return rows
    end
  end

  def queue_print_by(attribute)
    case @queue.empty?
    when true
      Messages.queue_empty
    else
      @queue = @queue.sort_by { |attendee|  attendee.send(attribute) }
      queue_print
    end
  end

  def print_terminal_table(rows)
    table = Terminal::Table.new :title => "--- CURRENT QUEUE ---", :headings => HEADER_ROW, :rows => rows
    puts table
  end

  def queue_district
    if @queue.size < 10
      rows = @queue.map { |attendee|  AttendeeData.data_with_districts(attendee) }
      AttendeeData.district_switch
    else
      rows = @queue.map { |attendee|  AttendeeData.data_from_attendee(attendee) }
    end
    print_terminal_table(rows)
    return rows
  end

  def queue_save_to(filename)
    File.open(filename, "w+") do |file|
      file.puts " ,#{HEADER_ROW.join(",")}"
        @queue.each_with_index do |attendee, index|
          file.puts "#{index + 1},#{AttendeeData.data_from_attendee(attendee).join(",")}"
        end
    end
  end

  def export_html(filename)
    HTMLExporter.export_html(filename, @queue)
  end

  def subtract(command)
    @queue = @queue - attendees.find(@queue, command[1], command[2])
  end

  def add(command)
    @queue = @queue + attendees.find(attendees.repo, command[1], command[2])
  end
end
