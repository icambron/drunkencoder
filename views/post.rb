require 'views/base'

class Post < Base
  def content
    div class: "post" do

      a href: @model.path do
        h1 do
          i class: "icon-glass"
          span " "
          span @model.title
        end
      end

      if @model.date
        h3 cal_date(@model.date)
      end
      
      div class: "actual-blog-content" do 
        rawtext @model.body
      end

      div class: "post-tags" do
        @model.tags.each do |tag|
          a class: "tag", href: "/archive?tag=#{tag}" do
            span class: "label label-info" do
              i class: "icon-tag"
              span " "
              span tag
            end
          end
          rawtext "&nbsp;"
        end
      end

      div class: "history" do
        a "Page history", href: "https://github.com/icambron/drunkencoder/commits/master/content#{@model.path}.isaac"
      end

      if @show_comments
        div id: "disqus_thread" do
          if Sinatra::Application.environment == :development
            javascript 'var disqus_developer = true;'
          end
          script type: 'text/javascript', src: "http://drunkencoder.disqus.com/embed.js", async: true
          
          noscript do
            a "view comments", href: "http://drunkencoder.disqus.com/enbed.js?url=ref"
          end
        end
      else
        div id: "view_comments" do
          a "View comments", href: @model.path + "#disqus_thread"
        end
      end
    end
  end
end
