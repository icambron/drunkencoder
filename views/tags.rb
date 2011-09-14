class Tags < Erector::Widget
  def content
    div :id => "tags_area", :class => "widgety_thing" do
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
end
