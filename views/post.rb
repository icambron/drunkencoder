class Post < Erector::Widget
  def content
    div :class => "post" do
      a :href => @model.linkify do
        h2 @model.title
      end
      div do 
        rawtext @model.body
      end
      div :class => "post_tags" do
        h3 "Tags"
        ul do
          @model.tags.each do |tag|
            li do
              a tag, :href => "/archive?tag=#{tag}"
            end
          end
        end
      end
      if @show_comments
        widget Comments.new
      end
    end
  end
end
