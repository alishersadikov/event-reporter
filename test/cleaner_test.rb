require './test/test_helper'
require './lib/cleaner'

class CleanerTest < Minitest::Test
  def test_it_reads_from_csv_file
    csv = Cleaner.new
    assert_equal 1, csv.read_from_csv
  end

end

# def read_from_csv
#   contents = CSV.open "event_attendees.csv", headers: true, header_converters: :symbol
# end
#
# id = row[0]
# name = row[:first_name]
# zipcode = clean_zipcode(row[:zipcode])
#
# def clean_zipcode(zipcode)
#   zipcode.to_s.rjust(5,"0")[0..4]
# end
#
# attr_reader :regdate,
#             :first_name,
#             :last_name,
#             :email,
#             :phone,
#             :street,
#             :city,
#             :state,
#             :zip_code
#
# def initialize(attendees)
#   @regdate          = data[:regdate]
#   @first_name       = Cleaner.downcaser(data[:first_name])
#   @last_name        = Cleaner.downcaser(data[:last_name])
#   @email            = Cleaner.downcaser(data[:email_address])
#   @phone            = Cleaner.format_phone_number(data[:homephone])
#   @street           = Cleaner.downcaser(data[:street])
#   @city             = Cleaner.downcaser(data[:city])
#   @state            = Cleaner.format_state(data[:state])
#   @zipcode          = Cleaner.format_zipcode(data[:zipcode])
# end
#
# def open_file
#
# end
# def initialize(filepath="event_attendees.csv")
#   @attendees = open_file(filepath)
# end
#
# def open_file
#   fileepath = "event_attendees.csv"
#   @attendees = open_file(filepath)
#
#   @contents = CSV.open(filepath, headers: true, header_converters: :symbol)
#   @contents.map { |row| Attendee.new(row) }
# end
