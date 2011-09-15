class PostSummary < Erector::Widget
  def content
    a(:href => @post.linkify) do
      span cal_date(@post.date), :class => "post_summary_date"
      span " " + @post.title, :class => "post_summary_title"
    end
  end

  def cal_date(date)
    if date.year == Time.new.year
      date.strftime('%m.%d')
    else
      date.strftime("%y.%m.%d")
    end
  end
end
