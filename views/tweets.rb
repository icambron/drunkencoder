require 'twitter-text'
require 'views/base'

class Tweets < Base
  include Twitter::Autolink
  def content
    div do
      h2 "Twitter"
      ul do
        @tweets.each do |tweet|
          li class: "icon-twitter-sign" do
            rawtext auto_link(tweet.text)
          end
        end
      end
      a "Follow me", :href => "http://twitter.com/icambron"
    end
  end
end
