require './test/test_helper'
require './lib/attendees_repository'

class AttendeesRepositoryTest < Minitest::Test

  def test_the_repository_is_empty_unless_loaded
    attendees = AttendeesRepository.new
    assert_equal 0, attendees.repo.size
  end

  def test_it_builds_repository_from_csv_file
    attendees = AttendeesRepository.new
    attendees.build_repository('event_attendees_short.csv')
    assert attendees.repo
    refute_equal 0, attendees.repo
  end

  def test_it_builds_repository_as_an_array_of_attendees
    attendees = AttendeesRepository.new
    attendees.build_repository('event_attendees_short.csv')
    assert_instance_of Array, attendees.repo
  end

  def test_repository_size_matches_number_of_attendees_in_csv_file
    attendees = AttendeesRepository.new
    attendees.build_repository('event_attendees_short.csv')
    assert_equal 34, attendees.repo.size
  end

  def test_it_instantiates_repository_elements_as_attendees
    attendees = AttendeesRepository.new
    attendees.build_repository('event_attendees_short.csv')
    assert_instance_of Attendee, attendees.repo.first
    assert_instance_of Attendee, attendees.repo.last
  end

  def test_it_stores_first_name_in_lowercase_in_repository
    attendees = AttendeesRepository.new
    attendees.build_repository("event_attendees_short.csv")
    assert_equal "allison", attendees.repo[0].first_name
  end

  def test_it_stores_last_name_in_lowercase_in_repository
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
    assert_equal "(615) 438-5000", attendees.repo[0].homephone
    assert_equal "(414) 520-5000", attendees.repo[1].homephone
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

  def test_it_stores_state_in_lowercase
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

  def test_it_can_pull_attributes_of_other_attendees
    attendees = AttendeesRepository.new
    attendees.build_repository('event_attendees_short.csv')
    assert_equal "allison", attendees.repo.first.first_name
    assert_equal "(530) 919-3000", attendees.repo[7].homephone
    assert_equal "94611", attendees.repo[12].zipcode
    assert_equal "gkjordandc@jumpstartlab.com", attendees.repo[15].email_address
  end

  def test_it_finds_attendees_by_given_attribute_and_criteria
    attendees = AttendeesRepository.new
    attendees.build_repository('event_attendees_short.csv')
    assert_equal 1, attendees.find("first_name", "laura").count
    assert_equal 1, attendees.find("city", "vancouver").count
    assert_equal 2, attendees.find("zipcode", "98122").count
    assert_equal 1, attendees.find("email_address", "cnroh@jumpstartlab.com").count
  end
end
