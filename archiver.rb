require 'mongo'
require 'twitter'
require 'config'

class TweetArchiver
  def initialize(tag)
    connection = Mongo::Connection.new
    db = connection[DATABASE_NAME]
    @tweets = db[COLLECTION_NAME]

    @tweets.create_index([['id', 1]], :uniq => true)
    @tweets.create_index([['tags', 1], ['id', -1]])

    @tag = tag
    @tweets_found = 0
  end

  def update
    puts "Запускается поиск в Twitter для `#{@tag}`..."
    save_tweets_for(@tag)
    print "Сохранено твитов: #{@tweets_found}. \n\n"
  end

  private

    def save_tweets_for(term)
      Twitter::Search.new(term).each do |tweet|
        @tweets_found += 1
        tweet_with_tag = tweet.to_hash.merge!({"tags" => [term]})
        @tweets.save(tweet_with_tag)
      end
    end

end