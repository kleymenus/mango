require_relative 'config'
require_relative 'archiver'
require_relative 'credentials'

TAGS.each do |tag|
  archive = TweetArchiver.new(tag)
  archive.update
end