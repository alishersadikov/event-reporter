module Cleaner
  extend self

  def general_formatter(data)
    data.nil? || data == "" ? "blank" : data.downcase
  end

  def clean_phone(number)
    digits = number.to_s.scan(/\d/).join
    return "invalid"   if digits.length < 10
    return "invalid"   if digits.length == 11 && digits[0] != "1"
    return "invalid"   if digits.length > 11
    return format_phone(digits[-10..-1])
  end

  def format_phone(digits)
    area_code  = digits[0..2]
    exchange   = digits[3..5]
    subscriber = digits[-4..-1]
    "(%s) %s-%s" % [area_code, exchange, subscriber]
  end

  def clean_zipcode(zipcode)
    digits = zipcode.to_s.scan(/\d/).join
    digits.rjust(5, "0")[0..4]
  end
end
