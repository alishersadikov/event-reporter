require './test/test_helper'
require './lib/container'
require './lib/attendees_repository'
require 'terminal-table'

class ContainerTest < Minitest::Test

  def test_header_row_is_an_array_of_headers
    header = Container::HEADER_ROW
    assert_instance_of Array, header
  end

  def test_queue_starts_out_empty
    container = Container.new
    assert_equal 0, container.queue.count
  end

  def test_queue_count_works
    attendees = AttendeesRepository.new
    container = Container.new
    attendees.build_repository('event_attendees_short.csv')
    container.queue = attendees.find("zipcode", "98122")
    assert_equal 2, container.handle_count
    assert_equal 2, container.process(["queue", "count"])
  end

  def test_queue_clear_works
    attendees = AttendeesRepository.new
    container = Container.new
    attendees.build_repository('event_attendees_short.csv')
    container.queue = attendees.find("zipcode", "98122")
    assert_equal [], container.process(["queue", "clear"])
  end

  def test_it_pulls_data_from_attendees_and_stores_as_an_array
    attendees = AttendeesRepository.new
    container = Container.new
    attendees.build_repository('event_attendees_short.csv')
    container.queue = attendees.find("zipcode", "98122")
    attendee_1 = container.queue[0]
    attendee_2 = container.queue[1]
    assert_instance_of Array, AttendeeData.data_from_attendee(attendee_1)
    assert_instance_of Array, AttendeeData.data_from_attendee(attendee_2)
  end

  def test_it_builds_rows_as_arrays_for_queue_print
    attendees = AttendeesRepository.new
    container = Container.new
    attendees.build_repository('event_attendees_short.csv')
    container.queue = attendees.find("zipcode", "98122")
    assert_instance_of Array, container.queue_print
    assert_equal 2, container.queue_print.size
  end

  def test_it_alters_rows_and_sorts_attendee_arrays_for_queue_print_by
    attendees = AttendeesRepository.new
    container = Container.new
    attendees.build_repository('event_attendees_short.csv')
    container.queue = attendees.find("zipcode", "98122")
    refute_equal container.queue_print, container.queue_print_by("first_name")
  end

  def test_it_alters_rows_for_queue_print_by_after_passing_command
    attendees = AttendeesRepository.new
    container = Container.new
    attendees.build_repository('event_attendees_short.csv')
    container.queue = attendees.find("zipcode", "98122")
    refute_equal container.queue_print, container.process(["queue", "print", "by", "first_name"])
  end

  def test_it_gets_congress_districts_if_entries_less_than_ten_and_queue_district_called
    attendees = AttendeesRepository.new
    container = Container.new
    attendees.build_repository('event_attendees_short.csv')
    container.queue = attendees.find("zipcode", "98122")
    assert_equal 2, container.queue.size
    assert_equal "7", container.queue_district.first.last
    assert_equal "7", container.queue_district.last.last
  end

  def test_it_gets_districts_with_less_than_ten_entries_after_queue_district_command
    attendees = AttendeesRepository.new
    container = Container.new
    attendees.build_repository('event_attendees_short.csv')
    container.queue = attendees.find("zipcode", "98122")
    assert_equal 2, container.queue.size
    assert_equal "7", container.process(["queue", "district"]).first.last
    assert_equal "7", container.process(["queue", "district"]).last.last
  end

  def test_it_does_not_get_congress_districts_if_entries_more_than_10
    attendees = AttendeesRepository.new
    container = Container.new
    attendees.build_repository('event_attendees_short.csv')
    container.queue = attendees.find("zipcode", "14841")
    assert_equal 16, container.queue.size
    assert_equal "not pulled", container.queue_district.first.last
    assert_equal "not pulled", container.queue_district.last.last
  end

  def test_it_alters_queue_after_calling_queue_district
    attendees = AttendeesRepository.new
    container = Container.new
    attendees.build_repository('event_attendees_short.csv')
    container.queue = attendees.find("zipcode", "98122")
    refute_equal container.queue_print, container.queue_district
  end

  def test_it_saves_queue_to_specified_destination
    attendees = AttendeesRepository.new
    container = Container.new
    attendees.build_repository('event_attendees_short.csv')
    container.queue_save_to('output.csv')
    assert File.exist?('output.csv')
  end

  def test_it_exports_html
    attendees = AttendeesRepository.new
    container = Container.new
    attendees.build_repository('event_attendees_short.csv')
    container.queue = attendees.find("zipcode", "14841")
    container.export_html("sample.csv")
    assert File.exist?('sample.html')
  end
end
