require 'twitter-text'

class Tweets < Erector::Widget  
  include Twitter::Autolink
  def content
    h2 "Twitter"
    @tweets.each do |tweet|
      p do
        rawtext auto_link(tweet.text)
      end
    end
    a "Follow me", :href => "http://twitter.com/icambron"
  end
end
