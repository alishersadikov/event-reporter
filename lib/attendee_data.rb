require './lib/sunlight'

module AttendeeData
extend self

  def district_switch
    @need_district = false
  end

  def data_from_attendee(attendee)
    [ attendee.last_name.capitalize,
      attendee.first_name.capitalize,
      attendee.email_address,
      attendee.zipcode,
      attendee.city.upcase,
      attendee.state.upcase,
      attendee.street.upcase,
      attendee.homephone,
      get_district(attendee.zipcode) ]
  end

  def get_district(zipcode)
    @need_district ? Sunlight.return_district(zipcode) : "not pulled"
  end

  def data_with_districts(attendee)
    @need_district = true
    data_from_attendee(attendee)
  end
end
