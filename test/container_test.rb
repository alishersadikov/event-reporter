require './test/test_helper'
require './lib/container'
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
    container = Container.new
    container.load_repository(["load", 'event_attendees_short.csv'])
    container.queue = container.search(["find", "zipcode", "98122"])
    assert_equal 2, container.handle_count
  end

  def test_queue_clear_works
    container = Container.new
    container.load_repository(["load", 'event_attendees_short.csv'])
    container.queue = container.search(["find", "zipcode", "98122"])
    assert_equal 2, container.handle_count
    container.queue_clear
    assert_equal 0, container.handle_count
  end

  def test_it_searches_repository_by_given_attribute_and_criteria
    container = Container.new
    container.load_repository(["load", 'event_attendees_short.csv'])
    container.queue = container.search(["find", "zipcode", "98122"])
    assert_equal 2, container.handle_count
  end

  def test_it_pulls_data_from_attendees_and_stores_as_an_array
    container = Container.new
    container.load_repository(["load", 'event_attendees_short.csv'])
    container.queue = container.search(["find", "zipcode", "98122"])
    attendee_1 = container.queue[0]
    attendee_2 = container.queue[1]
    assert_instance_of Array, AttendeeData.data_from_attendee(attendee_1)
    assert_instance_of Array, AttendeeData.data_from_attendee(attendee_2)
  end

  def test_it_builds_rows_as_arrays_for_queue_print
    container = Container.new
    container.load_repository(["load", 'event_attendees_short.csv'])
    container.queue = container.search(["find", "first_name", "allison"])
    assert_instance_of Array, container.queue_print
    assert_equal 1, container.queue_print.size
  end

  def test_it_alters_rows_and_sorts_attendee_arrays_for_queue_print_by
    container = Container.new
    container.load_repository(["load", 'event_attendees_short.csv'])
    container.queue = container.search(["find", "zipcode", "98122"])
    refute_equal container.queue_print, container.queue_print_by("first_name")
  end

  def test_it_alters_rows_for_queue_print_by_after_passing_command
    container = Container.new
    container.load_repository(["load", 'event_attendees_short.csv'])
    container.queue = container.search(["find", "zipcode", "98122"])
    expected = container.queue_print
    actual = container.queue_print_by("first_name")
    refute_equal expected, actual
  end

  def test_improved_find_works
    container = Container.new
    container.load_repository(["load", 'event_attendees_short.csv'])
    container.queue = container.improved_find(["find", "zipcode", "98122", "and", "first_name", "nash"])
    assert_equal 1, container.queue.size
    assert_equal "nash", container.queue.first.first_name
    assert_equal "98122", container.queue.first.zipcode
  end

  def test_it_gets_districts_with_less_than_ten_entries_after_queue_district_command
    container = Container.new
    container.load_repository(["load", 'event_attendees_short.csv'])
    container.queue = container.search(["find", "first_name", "allison"])
    assert_equal 1, container.queue.size
    assert_equal "0", container.queue_district.last.last
  end

  def test_it_does_not_get_congress_districts_if_entries_more_than_10
    container = Container.new
    container.load_repository(["load", 'event_attendees_short.csv'])
    container.queue = container.search(["find", "zipcode", "14841"])
    assert_equal 16, container.queue.size
    assert_equal "not pulled", container.queue_district.first.last
    assert_equal "not pulled", container.queue_district.last.last
  end

  def test_it_alters_queue_after_calling_queue_district
    container = Container.new
    container.load_repository(["load", 'event_attendees_short.csv'])
    container.queue = container.search(["find", "zipcode", "98122"])
    refute_equal container.queue_print, container.queue_district
  end

  def test_integration_with_attendee_data_and_district_switch
    container = Container.new
    container.load_repository(["load", 'event_attendees_short.csv'])
    container.queue = container.search(["find", "zipcode", "98122"])
    assert_equal "not pulled", container.queue_print.last.last
    assert_equal "7",container.queue_district.last.last
    assert_equal "not pulled", container.queue_print.last.last
  end

  def test_it_saves_queue_to_specified_destination
    container = Container.new
    container.load_repository(["load", 'event_attendees_short.csv'])
    container.queue = container.search(["find", "zipcode", "98122"])
    container.queue_save_to('output.csv')
    assert File.exist?('output.csv')
  end

  def test_it_exports_html
    container = Container.new
    container.load_repository(["load", 'event_attendees_short.csv'])
    container.queue = container.search(["find", "zipcode", "14841"])
    container.export_html("sample.csv")
    assert File.exist?('sample.html')
  end

  def test_it_subtracts_the_search_query_from_the_queue
    container = Container.new
    container.load_repository(["load", 'event_attendees_short.csv'])
    container.queue = container.search(["find", "zipcode", "14841"])
    assert_equal 16, container.handle_count
    container.subtract(["subtract", "zipcode", "14841"])
    assert_equal 0, container.handle_count
  end

  def test_it_adds_the_search_query_to_the_queue
    container = Container.new
    container.load_repository(["load", 'event_attendees_short.csv'])
    container.queue = container.search(["find", "zipcode", "14841"])
    assert_equal 16, container.handle_count
    container.add(["add", "zipcode", "98122"])
    assert_equal 18, container.handle_count
  end
end
