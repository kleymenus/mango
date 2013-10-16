require_relative 'config'
require_relative 'archiver'
require_relative 'credentials'

loop do
  TAGS.each do |tag|
    archive = TweetArchiver.new(tag)
    archive.update
  end
  print "\nСпим #{SLEEP_TIME} секунд\n"
  sleep(SLEEP_TIME)
end