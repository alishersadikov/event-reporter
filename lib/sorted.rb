require './lib/sunlight'

class Sorted
  attr_accessor :queue
  HEADER_ROW = ["LAST NAME","FIRST NAME","EMAIL","ZIPCODE","CITY","STATE","ADDRESS","PHONE","DISTRICT"]

  def initialize
    @queue = []
    @need_district = false
  end

  def process(command)
    return puts "#{queue.count}"        if command[1] == "count"
    return @queue = []                  if command[1] == "clear"
    return queue_print                  if command[1] == "print" && command[2].nil?
    return queue_print_by(command[3])   if command[1] == "print" && command[2] == "by"
    return queue_save_to(command[3])    if command[1] == "save"
    return queue_district               if command[1] == "district"
    return export_html(command[3])      if command[1] == "export" && command [2] == "html"
  end

  def queue_print
    rows = @queue.map do |attendee|
      data_from_attendee(attendee)
    end
    print_terminal_table(rows)
  end


  def queue_print_by(attribute)
    @queue = @queue.sort_by do |attendee|
      attendee.send(attribute)
    end
    rows = @queue.map do |attendee|
      data_from_attendee(attendee)
    end
    print_terminal_table(rows)
  end

  def print_terminal_table(rows)
    table = Terminal::Table.new :headings => HEADER_ROW, :rows => rows
    puts table
  end

  def get_district(zipcode)
    @queue.size > 10 && @need_district == false ? "not pulled" : Sunlight.return_district(zipcode)
  end

  def queue_district
    @need_district = true
    queue_print
  end

  def queue_save_to(filename)
    File.open(filename, "w+") do |file|
      file.puts " ,#{HEADER_ROW.join(",")}"
        @queue.each_with_index do |attendee, index|
          file.puts "#{index + 1},#{data_from_attendee(attendee).join(",")}"
        end
    end
  end

  def data_from_attendee(attendee)
    [attendee.last_name.capitalize,
      attendee.first_name.capitalize,
      attendee.email_address,
      attendee.zipcode,
      attendee.city.capitalize,
      attendee.state.upcase,
      attendee.street.upcase,
      attendee.homephone,
      get_district(attendee.zipcode)]
  end

  def export_html(filename)
    #rubular.com
    html_file = "#{filename[0..-5]}.html"
    if @queue.length <= 0
      puts "You need to populate your queue"
    else
      File.open(html_file,'w') do |file|
        # file.puts " ,#{HEADER_ROW.join(",")}"
        # @queue.each_with_index do |row, index|
        #   file.puts "#{index + 1},#{attendee(row).join(",")}"
        # end
        file.puts "<table>"
        file.puts "<tr>"
        HEADER_ROW.each do |header|
          file.puts "<th>#{header}</th>"
        end
        file.puts "</tr>"
        @queue.each do |attendee|
          file.puts "<tr>"
          data_from_attendee(attendee).each do |data_element|
            file.puts "<td>#{data_element}</td>"
          end
          file.puts "</tr>"
        end
        file.puts "</table>"
      end
    end
end


end
