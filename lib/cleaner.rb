module Cleaner

  def self.clean_phone(number)
    numbers_only = number.scan(/\d/).join
    zero_padded = numbers_only.ljust(10, "0")
  end

  def self.general_formatter(data)
    data == nil || "" ? "blank" : data.downcase
  end

  def self.clean_zipcode(zipcode)
    zipcode.to_s.rjust(5, "0")[0..4]
  end

end
