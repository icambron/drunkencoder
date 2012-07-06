require_relative 'base'

class Recent < Base
  def content
    div do
      h2 "Recent Posts"
      ul do
        @recent.each do |post|
          li class: "icon-glass" do
            widget PostSummary.new(:post => post)
          end
        end
      end
      a "Full archive", :href => "/archive"
    end
  end
end
