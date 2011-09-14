class Layout < Erector::Widget
  def content
    html do
      head do
        title render_title
        css "/css/styles.css"
        css "/css/syntax.css"
        
        rawtext <<STUFF 
<link rel='stylesheet' type='text/css' href='http://www.webputty.net/css/agtzfmNzc2ZpZGRsZXIMCxIEUGFnZRj-hBkM' />
<script type='text/javascript'>(function(w,d){if(w.location!=w.parent.location||w.location.search.indexOf('__preview_css__')>-1){var t=d.createElement('script');t.type='text/javascript';t.async=true;t.src='http://www.webputty.net/js/agtzfmNzc2ZpZGRsZXIMCxIEUGFnZRj-hBkM';(d.body||d.documentElement).appendChild(t);}})(window,document);</script>
STUFF
        
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
