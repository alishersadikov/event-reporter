require './test/test_helper'
require './lib/attendees_repository'

class AttendeeTest < Minitest::Test

  def test_repository_is_not_empty
    attendees = AttendeesRepository.new
    attendees.build_repository("event_attendees_short.csv")
    refute attendees.nil?
  end

  def test_it_stores_reg_date
    attendees = AttendeesRepository.new
    attendees.build_repository("event_attendees_short.csv")
    assert_equal "11/12/08 10:47", attendees.repo[0].regdate
  end

  def test_it_stores_first_name_in_lowercase
    attendees = AttendeesRepository.new
    attendees.build_repository("event_attendees_short.csv")
    assert_equal "allison", attendees.repo[0].first_name
  end

  def test_it_stores_last_name_in_lowercase
    attendees = AttendeesRepository.new
    attendees.build_repository("event_attendees_short.csv")
    assert_equal "nguyen", attendees.repo[0].last_name
  end

  def test_it_stores_email_address
    attendees = AttendeesRepository.new
    attendees.build_repository("event_attendees_short.csv")
    assert_equal "arannon@jumpstartlab.com", attendees.repo[0].email_address
  end

  def test_it_cleans_phone_numbers_and_stores
    attendees = AttendeesRepository.new
    attendees.build_repository("event_attendees_short.csv")
    assert_equal "6154385000", attendees.repo[0].homephone
    assert_equal "4145205000", attendees.repo[1].homephone
  end

  def test_it_stores_street_in_lowercase
    attendees = AttendeesRepository.new
    attendees.build_repository("event_attendees_short.csv")
    assert_equal "3155 19th st nw", attendees.repo[0].street
  end

  def test_it_stores_city_in_lowercase
    attendees = AttendeesRepository.new
    attendees.build_repository("event_attendees_short.csv")
    assert_equal "washington", attendees.repo[0].city
  end

  def test_it_stores_city_in_lowercase
    attendees = AttendeesRepository.new
    attendees.build_repository("event_attendees_short.csv")
    assert_equal "dc", attendees.repo[0].state
  end

  def test_it_stores_zip_code_in_lowercase
    attendees = AttendeesRepository.new
    attendees.build_repository("event_attendees_short.csv")
    assert_equal "20010", attendees.repo[0].zipcode
    assert_equal "07306", attendees.repo[3].zipcode
  end
end
