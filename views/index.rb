class Index < Layout
  def render_content
    @posts.each do |thing|
      widget Post.new(:model => thing)
    end
  end
end
