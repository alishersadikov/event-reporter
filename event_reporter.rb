Dir["./lib/*.rb"].each { |file| require "#{file}" }

cli = CLI.new

Messages.welcome

loop do
  cli.run
end
