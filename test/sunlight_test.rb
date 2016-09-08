require './test/test_helper'
require './lib/sunlight_file'

class SunglightTest < Minitest::Test
  def test_it_returns_districts_from_zipcodes
    zipcode_1 = "20010"
    zipcode_2 = "80246"
    zipcode_3 = "00924"

    assert_equal "0", Sunlight.return_district(zipcode_1)
    assert_equal "1", Sunlight.return_district(zipcode_2)
    assert_equal "0", Sunlight.return_district(zipcode_3)
  end
end
