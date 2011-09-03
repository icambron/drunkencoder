require 'views/layout'

class PostPage < Layout
  def render_content
    widget Post.new(:model => @post, :show_comments => true)
  end
end
