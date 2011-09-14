class Recent < Erector::Widget
  def content
    div :id => "recent_area", :class => "widgety_thing" do
      h2 "Recent"
      ul do
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
