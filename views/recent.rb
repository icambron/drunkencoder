class Recent < Erector::Widget
  def content
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
