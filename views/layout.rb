class Layout < Erector::Widget
  def content
    html do
      head do
        title render_title
        css "/css/styles.css"
        css "/css/syntax.css"
        
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
            div :id => "vanity_area", :class => "widgety_thing" do
              h2 "What"
              p "Isaac Cambron. He's a geek. He drinks too much. This is his blog."
            end

            widget Tweets.new(:tweets => @tweets)
            widget Recent.new(:recent => @recent)
            widget Tags.new(:tags => @tags)
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
