require 'terminal-table'
require './lib/messages'
require './lib/html_exporter'
require './lib/attendee_data'

class Container
  attr_accessor :queue, :messages
  HEADER_ROW = ["LAST NAME","FIRST NAME","EMAIL","ZIPCODE","CITY","STATE","ADDRESS","PHONE","DISTRICT"]

  def initialize
    @queue = []
    @messages = Messages.new
  end

  def process(command)
    return handle_count                 if command[1] == "count"
    return @queue = []                  if command[1] == "clear"
    return queue_print                  if command[1] == "print" && command[2].nil?
    return queue_print_by(command[3])   if command[1] == "print" && command[2] == "by"
    return queue_district               if command[1] == "district"
    return queue_save_to(command[3])    if command[1] == "save"
    return export_html(command[3])      if command[1] == "export" && command [2] == "html"
  end

  def handle_count
    messages.queue_count(queue.count)
    queue.count
  end

  def queue_print
    rows = @queue.map { |attendee|  AttendeeData.data_from_attendee(attendee) }
    print_terminal_table(rows)
    return rows
  end

  def queue_print_by(attribute)
    @queue = @queue.sort_by { |attendee|  attendee.send(attribute) }
    rows   = @queue.map { |attendee|  AttendeeData.data_from_attendee(attendee) }
    print_terminal_table(rows)
    return rows
  end

  def print_terminal_table(rows)
    table = Terminal::Table.new :headings => HEADER_ROW, :rows => rows
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
end
