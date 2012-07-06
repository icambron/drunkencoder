require 'views/base'

class Tags < Base
  def content
    div do
      h2 "Tags"
      ul do
        @tags.each do |tag|
          li class: "icon-tag" do
            a tag, :href => "archive?tag=#{tag}"
          end
        end
      end
    end
  end
end
