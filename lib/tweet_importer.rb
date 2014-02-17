require 'csv'
require 'twitter'
require_relative '../app/models/tweet'

module TweetImporter

  FIELDS = [:twitter_id]

  CONFIG = {
      :consumer_key => # deleted for security,
      :consumer_secret => # deleted for security,
      }

  def self.import(filename)

    client = Twitter::REST::Client.new(CONFIG)

    csv = CSV.new(File.open(filename), :headers => true, :header_converters => :symbol)
    twitter_ids = []
    csv.each do |row|
      twitter_ids << filtered_attributes(row)
    end
    twitter_ids.keep_if do |hash|
      hash[:twitter_id] != ""
    end

    twitter_ids.each do |user_hash|
      client.search("from:#{user_hash[:twitter_id]}", :result_type => "recent").take(10).each do |tweet|
        Tweet.create!({:twitter_id => tweet.user.screen_name, :content => tweet.text, :tweet_id => tweet.id})
      end
    end
  end

  def self.filtered_attributes(row)
    filtered_attributes = row.to_hash.keep_if { |field, _| FIELDS.include?(field) }
  end

end


TweetImporter.import('db/data/legislators.csv')
