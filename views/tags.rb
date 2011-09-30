require 'views/base'

class Tags < Base
  def content
    div :class => "widgety_thing" do
      h2 "Tags"
      ul :class => "tags_list" do
        @tags.each do |tag|
          li do
            a tag, :href => "archive?tag=#{tag}"
          end
        end
      end
    end
  end
end
