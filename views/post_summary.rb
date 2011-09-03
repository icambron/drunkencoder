class PostSummary < Erector::Widget
  def content
    a(:href => @post.linkify) do
      span @post.date.strftime('%Y/%m/%d'), :class => "post_summary_date"
      span @post.title, :class => "post_summary_title"
    end
  end
end
