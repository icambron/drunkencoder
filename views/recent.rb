class Recent < Erector::Widget
  def content
    div :class => "widgety_thing" do
      h2 "Recent Posts"
      ul :class => "recent_list" do
        @recent.each do |post|
          li do
            widget PostSummary.new(:post => post)
          end
        end
      end
      a "Full archive", :href => "/archive"
    end
  end
end
