require './lib/cleaner'

class Attendee
  attr_accessor :first_name,:last_name,
                :email_address,:homephone,
                :street,:city,
                :state,:zipcode,
                :district

  def initialize(row)
    @first_name       = Cleaner.general_formatter(row[:first_name])
    @last_name        = Cleaner.general_formatter(row[:last_name])
    @email_address    = Cleaner.general_formatter(row[:email_address])
    @homephone        = Cleaner.clean_phone(row[:homephone])
    @street           = Cleaner.general_formatter(row[:street])
    @city             = Cleaner.general_formatter(row[:city])
    @state            = Cleaner.general_formatter(row[:state])
    @zipcode          = Cleaner.clean_zipcode(row[:zipcode])
  end
end
