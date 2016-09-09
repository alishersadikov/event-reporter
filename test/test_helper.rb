require 'simplecov'
SimpleCov.start do

  add_filter 'lib/messages'
  add_filter 'lib/Messages'
end
require 'minitest/autorun'
require 'minitest/pride'
