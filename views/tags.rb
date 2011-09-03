class Tags < Erector::Widget
  def content
    h2 "Tags"
    ul do
      @tags.each do |tag|
        li do
          a tag, :href => "archive?tag=#{tag}"
        end
      end
    end
  end
end
