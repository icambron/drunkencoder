require 'views/layout'

class Archive < Layout
  def render_title
    @title
  end

  def render_content
    h1 @title
    ul do
      @posts.each do |post|
        li do
          widget PostSummary.new(:post => post)
        end
      end
    end
  end
end
