class Comments < Erector::Widget
  def content
    div :id => "disqus_thread" do
      if Sinatra::Application.environment == :development
        javascript 'var disqus_developer = true;'
      end
      script :type => 'text/javascript', :src => "http://drunkencoder.disqus.com/embed.js", :async => true
      
      noscript do
        a "view comments", :href => "http://drunkencoder.disqus.com/enbed.js?url=ref"
      end
    end
  end
end
