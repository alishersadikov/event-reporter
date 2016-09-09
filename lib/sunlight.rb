require 'congress'

module Sunlight
  extend self

  def return_district(zipcode)
    client = Congress::Client.new('df898acc5c8e49cdaaaa2e30e240b2d1')
    client.districts_locate(zipcode).to_hash["results"][0]["district"].to_s
  end
end
