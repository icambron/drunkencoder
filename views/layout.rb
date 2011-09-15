class Layout < Erector::Widget
  def content
    html do
      head do
        title render_title
        css "/css/styles.css"
        css "/css/syntax.css"
        link :href => "/feed.xml", :rel => "alternate", :type => "application/atom+xml"
      end
      body do
        div :id => "title_area" do
          h1 do 
            a "Drunken Coder", :href => "/"
          end
          h2 "The booze does the coding; I'm just here for the ride."
          div :class => "clear"
        end
          
        div :id => "content_wrapper" do
          div :id => "content_area" do
            render_content
          end
          
          div :id => "sidebar" do
            div :class => "widgety_thing" do
              h2 "What"
              p "Isaac Cambron. He's a geek. He drinks a lot. This is his blog."
              ul do
                li :class => "atom_link" do
                  a "Atom feed", :href => "/feed.xml"
                end
                li :class => "github_link" do
                  a "Githubbery", :href => "http://github.com/icambron"
                end
              end
            end

            widget Tweets.new(:tweets => @tweets)
            widget Recent.new(:recent => @recent)
            widget Tags.new(:tags => @tags)
          end

          div :class => "clear"
        end
        
        div :id => "footer" do
          div do 
            img :src => "/images/Attribution-ShareAlike.png"
          end
          p do
            span "Content on this site is licensed under a "
            a "Creative Commons Attribution-ShareAlike", :href => "http://creativecommons.org/licenses/by-sa/3.0/"
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
