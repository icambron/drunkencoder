require 'views/base'

class Post < Base
  def content
    div :class => "post" do

      a :href => @model.path do
        h1 @model.title
      end

      if @model.date
        div "Published #{cal_date @model.date}", :class => "post_date"
      end
      
      div :class => "actual_blog_content" do 
        rawtext @model.body
      end

      div :class => "post_tags" do
        span "Tags: "
        @model.tags.each do |tag|
          span do
            a tag, :href => "/archive?tag=#{tag}"
            span ", " if tag != @model.tags.last
          end
        end
      end
      if @show_comments
        div :id => "disqus_thread" do
          if Sinatra::Application.environment == :development
            javascript 'var disqus_developer = true;'
          end
          script :type => 'text/javascript', :src => "http://drunkencoder.disqus.com/embed.js", :async => true
          
          noscript do
            a "view comments", :href => "http://drunkencoder.disqus.com/enbed.js?url=ref"
          end
        end
      else
        div :id => "view_comments" do
          a "View comments", :href => @model.path + "#disqus_thread"
        end
      end
    end
  end
end
