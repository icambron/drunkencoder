require 'views/base'

class Layout < Base
  def content
    rawtext "<!DOCTYPE html>"
    html do
      head do
        title render_title
        css "/assets/application.css"
        link href: "/feed.xml", rel: "alternate", type: "application/atom+xml"
        script src: "assets/application.js"

        rawtext "<!--[if lt IE 9]>"
        rawtext '<script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>'
        rawtext '<![endif]-->'

      end

      body do

        div class: "navbar navbar-fixed-top" do
          div class: "navbar-inner" do
            div class: "container" do

              a class: "btn btn-navbar", "data-toggle" => "collapse", "data-target" => ".nav-collapse" do
                span class: "icon-bar"
                span class: "icon-bar"
                span class: "icon-bar"
              end

              a "Drunken Coder", :href => "/", class: "brand" 

              div class: "nav-collapse" do
                ul class: "nav" do

                  li do
                    a href: "/" do
                      i class: "icon-home"
                      span "Home"
                    end
                  end

                  li do
                    a href: "/archive" do
                      i class: "icon-briefcase"
                      span "Archive"
                    end
                  end

                  li do
                    a href: "/feed.xml" do
                      i class: "icon-rss"
                      span "Feed"
                    end
                  end
                end
              end
            end
          end
        end

        div class: "container" do

          div class: 'row' do
            div class: "span7" do
              render_content
            end

            div class: "span3 visible-desktop" do
              h2 "What"
              p "Isaac Cambron. He's a geek. He drinks a lot. This is his blog."

              ul do
                li class: "icon-github" do
                  a href: "http://github.com/icambron" do
                    span "Githubbery"
                  end
                end
              end

              widget Tweets.new(tweets: @tweets)
              widget Recent.new(recent: @recent)
              widget Tags.new(tags: @tags)

            end
          end
        end
          
        footer class: "footer" do
          div do 
            img src: "/images/Attribution-ShareAlike.png"
          end
          p  do 
            rawtext "&copy;"
            span " 2012 Isaac Cambron"
          end
          p do
            span "Content on this site is licensed under a "
            a "Creative Commons Attribution-ShareAlike", href: "http://creativecommons.org/licenses/by-sa/3.0/"
            span "."
          end
        end
      end
    end
  end
  
  def render_title
    "Drunken Coder"
  end
  
  def render_content
    raise "Implement me, fool"
  end
end
