module Cleaner
  extend self

  def clean_phone(number)
    numbers_only = number.to_s.scan(/\d/).join
    zero_padded = numbers_only.ljust(10, "0")
  end

  def general_formatter(data)
    data.nil? || data == "" ? "blank" : data.downcase
  end

  def clean_zipcode(zipcode)
    zipcode.to_s.rjust(5, "0")[0..4]
  end

end
