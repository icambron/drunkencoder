require 'views/base'

class PostSummary < Base
  def content
    a(:href => @post.path) do
      span cal_date(@post.date)
      span " - " + @post.title
    end
  end
end
