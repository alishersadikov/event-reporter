require './test/test_helper'
require './lib/attendees_repository'

class AttendeesRepositoryTest < Minitest::Test
  def test_it_reads_from_csv_file
    csv = AttendeesRepository.new
    assert_equal 5175, csv.build_repository('event_attendees.csv').count
  end
end
