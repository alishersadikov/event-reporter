Dir["./lib/*.rb"].each { |file| require "#{file}" }

messages = Messages.new
cli = CLI.new

messages.welcome

loop do
  cli.run
end
