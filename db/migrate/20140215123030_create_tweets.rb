require_relative '../config'

class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :twitter_id
      t.string :content
      t.integer :tweet_id
      t.timestamps
    end
  end
    # HINT: checkout ActiveRecord::Migration.create_table
end
