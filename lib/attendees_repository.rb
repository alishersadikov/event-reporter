require 'csv'
require './lib/attendee'

class AttendeesRepository
  attr_accessor :repo

  def initialize
    @repo = []
  end

  def build_repository(filename)
    contents = CSV.open filename, headers: true, header_converters: :symbol
    contents.each { |row| @repo << Attendee.new(row) }
    return @repo
  end

  def load_repo
 
  end
end


  # def open_file(filepath)
  #   @contents = CSV.open(filepath, headers: true, header_converters: :symbol)
  #   build_attendee_by_row
  # end
  #
  # def build_attendee_by_row
  #   @contents.map { |row| Attendee.new(row) }
  # end
  #
  # def find_by(option, criteria)
  #   attendees.select do |attendee|P-=;;;M\\\\\\\\\\[[[[[[[[
  #     /M=[;;;-8JU
  #     ]
  #     ]]]]]]
  #     attendee if attendee.send(option.to_sym).downcase == criteria.downcase
  #   end
  # end
