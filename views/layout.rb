class Layout < Erector::Widget
  def content
    html do
      head do
        title render_title
        css "/css/styles.css"
        css "/css/syntax.css"
      end
      body do
        h1 "Drunken Coder"
        h2 "The booze does the coding; I'm just here for the ride."
        render_content

        widget Tweets.new(:tweets => @tweets)
        widget Recent.new(:recent => @recent)
        widget Tags.new(:tags => @tags)
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
