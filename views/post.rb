class Post < Erector::Widget
  def content
    div :class => "post" do
      a :href => @model.path do
        h1 @model.title
      end
      div :class => "actual_blog_content" do 
        rawtext @model.body
      end
      div :class => "post_tags" do
        span "Tags: "
        @model.tags.each do |tag|
          span do
            a tag, :href => "/archive?tag=#{tag}"
            span ", " if tag != @model.tags.last
          end
        end
      end
      if @show_comments
        widget Comments.new
      end
    end
  end
end
