require 'csv'
require './lib/attendee'

class AttendeesRepository
  attr_accessor :repo

  def initialize
    @repo = []
  end

  def build_repository(filename = 'event_attendees.csv')
    contents = CSV.open filename, headers: true, header_converters: :symbol
    contents.each { |row|  @repo << Attendee.new(row) }
    return @repo
  end

  def find(data, attribute, criteria)
    search_query = data.find_all { |attendee|  attendee.send(attribute) == criteria }
    return search_query
  end
end
