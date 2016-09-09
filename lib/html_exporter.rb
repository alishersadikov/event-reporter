module HTMLExporter
  require "./lib/attendee_data"
  extend self

  HEADER_ROW = ["LAST NAME","FIRST NAME","EMAIL","ZIPCODE","CITY","STATE","ADDRESS","PHONE","DISTRICT"]

  def export_html(filename, queue)
    html_file = "#{filename.split(".")[0]}.html"
    if queue.empty?
      puts "You need to populate your queue"
    else
      File.open(html_file,'w') { |file|  build_full_html(file, queue) }
    end
  end

  def build_full_html(file, queue)
    file.puts "<table>\n<tr>"
    header_format_html(file)
    file.puts "</tr>"
    queue_format_html(file, queue)
    file.puts "</table>"
  end

  def header_format_html(file)
    HEADER_ROW.map { |header|  file.puts "<th>#{header}</th>" }
  end

  def queue_format_html(file, queue)
    queue.map do |attendee|
      file.puts "<tr>"
      AttendeeData.data_from_attendee(attendee).each do |data_element|
        file.puts "<td>#{data_element}</td>"
      end
      file.puts "</tr>"
    end
  end
end
