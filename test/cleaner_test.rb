require './test/test_helper'
require './lib/cleaner'

class CleanerTest < Minitest::Test

  def test_general_formatter_changes_to_lowercase
    assert_equal "allison", Cleaner.general_formatter("Allison")
    assert_equal "john", Cleaner.general_formatter("John")
  end

  def test_general_formatter_returns_blank_for_nil_and_empty_string
    assert_equal "blank", Cleaner.general_formatter(nil)
    assert_equal "blank", Cleaner.general_formatter("")
  end

  def test_it_formats_correct_phone_number
    assert_equal "(414) 520-5000", Cleaner.format_phone("4145205000")
    assert_equal "(202) 238-1000", Cleaner.format_phone("2022381000")
  end

  def test_it_cleans_up_the_phone_number_before_formatting
    assert_equal "(414) 520-5000", Cleaner.clean_phone("414-520-5000")
    assert_equal "(202) 238-1000", Cleaner.clean_phone("(202) 238 1000")
  end

  def test_it_returns_invalid_if_phone_number_is_too_long_or_short
    assert_equal "invalid", Cleaner.clean_phone("12345678")
    assert_equal "invalid", Cleaner.clean_phone("23456789012")
    assert_equal "invalid", Cleaner.clean_phone("123456789012")
  end

  def test_it_removes_the_country_code
    assert_equal "(234) 567-8911", Cleaner.clean_phone("12345678911")
  end

  def test_it_returns_invalid_if_phone_number_is_nil_or_empty_string
    assert_equal "invalid", Cleaner.clean_phone(nil)
    assert_equal "invalid", Cleaner.clean_phone("")
  end

  def test_it_cleans_zip_codes
    assert_equal "80202", Cleaner.clean_zipcode("802-02")
    assert_equal "80202", Cleaner.clean_zipcode("*802(02")
  end

  def test_it_pads_zipcode_with_zeros
    assert_equal "07856", Cleaner.clean_zipcode("7856")
    assert_equal "00926", Cleaner.clean_zipcode("926")
  end

  def test_it_returs_zeros_if_zip_code_is_nil_or_empty_string
    assert_equal "00000", Cleaner.clean_zipcode(nil)
    assert_equal "00000", Cleaner.clean_zipcode("")
  end

  def test_it_downcases_city_names
    assert_equal "salt lake city", Cleaner.general_formatter("Salt Lake City")
    assert_equal "denver", Cleaner.general_formatter("Denver")
  end
end
