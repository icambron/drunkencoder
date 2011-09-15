require 'twitter-text'

class Tweets < Erector::Widget  
  include Twitter::Autolink
  def content
    div :class => "widgety_thing" do
      h2 "Twitter"
      ul :class => "tweet_list" do
        @tweets.each do |tweet|
          li do
            rawtext auto_link(tweet.text)
          end
        end
      end
      a "Follow me", :href => "http://twitter.com/icambron"
    end
  end
end
