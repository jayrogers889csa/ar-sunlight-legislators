require_relative '../../db/config'

class Tweet < ActiveRecord::Base

  belongs_to :legislator, foreign_key: :twitter_id
  validates :tweet_id, uniqueness: true

  def self.print_ten_tweets(twitter_id)
    self.select_twitter_user(twitter_id).each do |tweet|
      puts "Author: #{tweet.twitter_id} Text: #{tweet.content} Tweet_ID: #{tweet.tweet_id}"
    end
  end

  def self.select_twitter_user(twitter_id)
    self.where('twitter_id= ?', twitter_id)
  end
end
