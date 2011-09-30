class PostSummary < Base
  def content
    a(:href => @post.path) do
      span cal_date(@post.date), :class => "post_summary_date"
      span " " + @post.title, :class => "post_summary_title"
    end
  end
end
