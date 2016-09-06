require './test/test_helper'
require './lib/cleaner'

class CleanerTest < Minitest::Test

  def test_general_formatter_changes_to_lowercase
    assert_equal "allison", Cleaner.general_formatter("Allison")
  end

  def test_general_formatter_returns_blank_for_nil_and_empty_string
    assert_equal "blank", Cleaner.general_formatter(nil)
    assert_equal "blank", Cleaner.general_formatter("")
  end

  def test_it_cleans_up_the_phone_number
    assert_equal "4145205000", Cleaner.clean_phone("414-520-5000")
    assert_equal "2023281000", Cleaner.clean_phone("(202) 328 1000")
  end

  def test_it_returns_zeros_if_phone_number_is_nil_or_empty_string
    assert_equal "0000000000", Cleaner.clean_phone(nil)
    assert_equal "0000000000", Cleaner.clean_phone("")
  end

  def test_it_cleans_zip_codes
    assert_equal "07287", Cleaner.clean_zipcode("7287")
    assert_equal "00924", Cleaner.clean_zipcode("924")
  end

  def test_it_returs_zeros_if_zip_code_is_nil_or_empty_string
    assert_equal "00000", Cleaner.clean_zipcode(nil)
    assert_equal "00000", Cleaner.clean_zipcode("")
  end
end
