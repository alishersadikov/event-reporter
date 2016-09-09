require './test/test_helper'
require './lib/attendee'

class AttendeeTest < Minitest::Test

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

  def test_it_has_all_the_correct_attributes
    attendee = Attendee.new(row)

    assert_equal "allison", attendee.first_name
    assert_equal "nguyen", attendee.last_name
    assert_equal "arannon@jumpstartlab.com", attendee.email_address
    assert_equal "(615) 485-0000", attendee.homephone
    assert_equal "3155 19th st nw", attendee.street
    assert_equal "washington", attendee.city
    assert_equal "dc", attendee.state
    assert_equal "20010", attendee.zipcode
  end
end
