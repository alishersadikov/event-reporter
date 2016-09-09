require './test/test_helper'
require './lib/attendee_data'
require './lib/attendee'

class AttendeeDataTest < Minitest::Test

  def test_switch_returns_false_by_default
    assert_equal false, AttendeeData.district_switch
  end

  def row
    {:first_name => "Allison",
      :last_name => "Nguyen",
      :email_address => "arannon@jumpstartlab.com",
      :homephone => "6154850000",
      :street => "3155 19th St NW",
      :city => "Washington",
      :state => "DC",
      :zipcode => "20010"}
  end

  def test_data_from_attendee_is_pulled_and_stored_in_an_array
    attendee = Attendee.new(row)
    expected = ["Nguyen", "Allison", "arannon@jumpstartlab.com", "20010",
                "WASHINGTON", "DC", "3155 19TH ST NW", "(615) 485-0000", "not pulled"]
    assert_equal expected, AttendeeData.data_from_attendee(attendee)
  end

  def test_it_does_not_provide_congress_district_unless_requested
    attendee = Attendee.new(row)
    expected = ["Nguyen", "Allison", "arannon@jumpstartlab.com", "20010",
                "WASHINGTON", "DC", "3155 19TH ST NW", "(615) 485-0000", "not pulled"]
    assert_equal "not pulled", AttendeeData.get_district("20010")
    assert_equal "not pulled", AttendeeData.data_from_attendee(attendee).last
  end

  def test_it_provides_congress_districts_when_requested
    attendee = Attendee.new(row)
    expected = ["Nguyen", "Allison", "arannon@jumpstartlab.com", "20010",
                "WASHINGTON", "DC", "3155 19TH ST NW", "(615) 485-0000", "0"]
    assert_equal expected, AttendeeData.data_with_districts(attendee)
    assert_equal "0", AttendeeData.data_with_districts(attendee).last
    assert_equal "0", AttendeeData.get_district("20010")
  end
end
